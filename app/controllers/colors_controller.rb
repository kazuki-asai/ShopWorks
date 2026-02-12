class ColorsController < ApplicationController
  before_action :set_color, only: %i[show edit update destroy]

  def index
    @colors = Color.includes(:shop).by_current_shop
  end

  def show
  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      redirect_to colors_path, notice: "色を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @color.update(color_params)
      redirect_to colors_path, notice: "色を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @color.destroy
    redirect_to colors_path, notice: "色を削除しました。"
  end

  def create_defaults
    shop_id = current_user.admin? ? params[:shop_id] : current_user.shop_id
    defaults = [
      { name: "ブラック", position: 1, hex_code: '#000000' },
      { name: "ホワイト", position: 2, hex_code: '#FFFFFF' },
      { name: "レッド", position: 3, hex_code: '#FF0000' },
      { name: "ブルー", position: 4, hex_code: '#0000FF' },
      { name: "グリーン", position: 5, hex_code: '#008000' }
    ]
    default_names = defaults.map { |d| d[:name] }
    Color.where(shop_id: shop_id, name: default_names).destroy_all

    defaults.each do |attrs|
      Color.create!(name: attrs[:name], shop_id: shop_id, position: attrs[:position], hex_code: attrs[:hex_code])
    end
    redirect_to colors_path, notice: "定番カラーを作成しました。"
  end

  private

  def set_color
    @color = Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :shop_id, :position, :hex_code)
  end
end
