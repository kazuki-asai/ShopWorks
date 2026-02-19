class Api::BaseController < ActionController::API
  before_action :set_shop

  private

  def set_shop
    @shop = Shop.find(params[:shop_id]) if params[:shop_id].present?
  end
end
