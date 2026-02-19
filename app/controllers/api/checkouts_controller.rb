class Api::CheckoutsController < Api::BaseController
  def create
    product = Product.find(params[:product_id])
    quantity = (params[:quantity] || 1).to_i
    customer = Customer.find_by(id: params[:customer_id])

    purchase_history = CustomerPurchaseHistory.create!(
      customer: customer || Customer.find(params[:customer_id]),
      product: product,
      shop: product.shop,
      quantity: quantity,
      total_price: product.price * quantity,
      ordered_at: Time.current
    )

    session = ::Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price_data: {
          currency: "jpy",
          product_data: { name: product.name },
          unit_amount: product.price
        },
        quantity: quantity
      } ],
      mode: "payment",
      success_url: params[:success_url] || root_url,
      cancel_url: params[:cancel_url] || root_url,
      metadata: { purchase_history_id: purchase_history.id }
    )

    purchase_history.create_order!(
      stripe_checkout_session_id: session.id,
      payment_status: :pending,
      customer_email: params[:customer_email]
    )

    render json: { checkout_url: session.url, session_id: session.id }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue ::Stripe::StripeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
