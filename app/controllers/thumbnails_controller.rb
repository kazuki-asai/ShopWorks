class ThumbnailsController < ApplicationController
  def destroy
    @product = Product.find(params[:product_id])
    @thumbnail = @product.thumbnails.find(params[:id])
    @thumbnail.destroy
    redirect_back fallback_location: edit_product_path(@product), notice: "画像を削除しました。"
  end
end
