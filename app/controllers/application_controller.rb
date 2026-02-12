class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :auto_authorize!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    Current.user = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def auto_authorize!
    return if devise_controller?

    authorize "#{controller_path}_controller".to_sym, "#{action_name}?".to_sym
  end

  def user_not_authorized
    flash[:alert] = "この操作を行う権限がありません。"
    redirect_back(fallback_location: root_path)
  end
end
