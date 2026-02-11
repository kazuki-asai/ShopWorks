class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(created_at: :desc)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "ユーザーを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if user_params[:password].blank?
      if @user.update(user_params.except(:password, :password_confirmation))
        redirect_to users_path, notice: "ユーザーを更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      if @user.update(user_params)
        redirect_to users_path, notice: "ユーザーを更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "ユーザーを削除しました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :shop_id)
  end
end
