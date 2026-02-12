class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.includes(:shop).by_current_shop.order(created_at: :desc)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      save_thumbnails(@product)
      redirect_to products_path, notice: "商品を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      save_thumbnails(@product)
      redirect_to products_path, notice: "商品を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "商品を削除しました。"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :detail, :price, :shop_id, size_ids: [], color_ids: [])
  end

  def save_thumbnails(product)
    return unless params[:images].present?

    params[:images].each do |image|
      thumbnail = product.thumbnails.build
      thumbnail.image.attach(image)
      thumbnail.save
    end
  end
end
