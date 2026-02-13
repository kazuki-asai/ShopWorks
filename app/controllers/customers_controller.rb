class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.active.includes(:shop).by_current_shop.order(created_at: :desc)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "顧客を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "顧客を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.soft_delete
    redirect_to customers_path, notice: "顧客を削除しました。"
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :shop_id, :address, :postal_code, :password, :last_name_kana, :first_name_kana, :gender, :birthday)
  end
end
