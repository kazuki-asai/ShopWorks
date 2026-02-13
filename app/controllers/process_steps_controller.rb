class ProcessStepsController < ApplicationController
  before_action :set_process_step, only: %i[show edit update destroy]

  def index
    @process_steps = ProcessStep.includes(:shop).by_current_shop
  end

  def show
  end

  def new
    @process_step = ProcessStep.new
  end

  def create
    @process_step = ProcessStep.new(process_step_params)
    if @process_step.save
      redirect_to process_steps_path, notice: "工程を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @process_step.update(process_step_params)
      redirect_to process_steps_path, notice: "工程を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @process_step.destroy
    redirect_to process_steps_path, notice: "工程を削除しました。"
  end

  def create_defaults
    shop_id = current_user.admin? ? params[:shop_id] : current_user.shop_id
    defaults = [
      { name: "製造中", position: 1 },
      { name: "発送準備中", position: 2 },
      { name: "発送済み", position: 3 }
    ]
    default_names = defaults.map { |d| d[:name] }
    ProcessStep.where(shop_id: shop_id, name: default_names).destroy_all

    defaults.each do |attrs|
      ProcessStep.create!(name: attrs[:name], shop_id: shop_id, position: attrs[:position])
    end
    redirect_to process_steps_path, notice: "定番工程を作成しました。"
  end

  private

  def set_process_step
    @process_step = ProcessStep.find(params[:id])
  end

  def process_step_params
    params.require(:process_step).permit(:name, :shop_id, :position)
  end
end
