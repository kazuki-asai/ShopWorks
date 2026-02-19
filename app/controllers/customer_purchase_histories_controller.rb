class CustomerPurchaseHistoriesController < ApplicationController
  before_action :set_customer_purchase_history, only: %i[show edit update destroy]

  def index
    @customer_purchase_histories = CustomerPurchaseHistory.includes(:customer, :product, :shop, :order).by_current_shop.order(ordered_at: :desc)
  end

  def show
  end

  def new
    @customer_purchase_history = CustomerPurchaseHistory.new
  end

  def create
    @customer_purchase_history = CustomerPurchaseHistory.new(customer_purchase_history_params)
    if @customer_purchase_history.save
      redirect_to customer_purchase_histories_path, notice: "購入履歴を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer_purchase_history.update(customer_purchase_history_params)
      redirect_to customer_purchase_histories_path, notice: "購入履歴を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer_purchase_history.destroy
    redirect_to customer_purchase_histories_path, notice: "購入履歴を削除しました。"
  end

  private

  def set_customer_purchase_history
    @customer_purchase_history = CustomerPurchaseHistory.find(params[:id])
  end

  def customer_purchase_history_params
    params.require(:customer_purchase_history).permit(:customer_id, :product_id, :shop_id, :quantity, :total_price, :ordered_at, :note)
  end
end
