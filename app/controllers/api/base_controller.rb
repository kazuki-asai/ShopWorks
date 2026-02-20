class Api::BaseController < ActionController::API
  before_action :set_shop

  private

  def set_shop
    @shop = Shop.find_by!(code: params[:shop_code]) if params[:shop_code].present?
  end
end
