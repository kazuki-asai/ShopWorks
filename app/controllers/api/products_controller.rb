class Api::ProductsController < Api::BaseController
  def index
    products = if @shop
      @shop.products.includes(thumbnails: { image_attachment: :blob })
    else
      Product.includes(thumbnails: { image_attachment: :blob }).all
    end

    render json: products.map { |p| product_json(p) }
  end

  def show
    product = Product.find(params[:id])
    render json: product_json(product)
  end

  private

  def product_json(product)
    {
      id: product.id,
      name: product.name,
      description: product.description,
      detail: product.detail,
      price: product.price,
      shop_id: product.shop_id,
      images: product.thumbnails.map { |t|
        t.image.attached? ? rails_blob_url(t.image, only_path: false) : nil
      }.compact
    }
  end
end
