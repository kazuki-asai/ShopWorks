class Webhooks::StripeController < ActionController::API
  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"]

    event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)

    case event.type
    when "checkout.session.completed"
      session = event.data.object
      order = Order.find_by!(stripe_checkout_session_id: session.id)
      order.update!(
        payment_status: :paid,
        stripe_payment_intent_id: session.payment_intent,
        customer_email: session.customer_details&.email
      )
    end

    head :ok
  rescue Stripe::SignatureVerificationError
    head :bad_request
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
