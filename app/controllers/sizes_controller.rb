class SizesController < ApplicationController
  before_action :set_size, only: %i[show edit update destroy]

  def index
    @sizes = Size.includes(:shop).by_current_shop
  end

  def show
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new(size_params)
    if @size.save
      redirect_to sizes_path, notice: "サイズを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @size.update(size_params)
      redirect_to sizes_path, notice: "サイズを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @size.destroy
    redirect_to sizes_path, notice: "サイズを削除しました。"
  end

  def create_defaults
    shop_id = current_user.admin? ? params[:shop_id] : current_user.shop_id
    defaults = [
      { name: "S", position: 1 },
      { name: "M", position: 2 },
      { name: "L", position: 3 },
      { name: "XL", position: 4 }
    ]
    default_names = defaults.map { |d| d[:name] }
    Size.where(shop_id: shop_id, name: default_names).destroy_all

    defaults.each do |attrs|
      Size.create!(name: attrs[:name], shop_id: shop_id, position: attrs[:position])
    end
    redirect_to sizes_path, notice: "定番サイズを作成しました。"
  end

  private

  def set_size
    @size = Size.find(params[:id])
  end

  def size_params
    params.require(:size).permit(:name, :shop_id, :position)
  end
end
