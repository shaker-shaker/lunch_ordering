class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def after_sign_out_path_for(resource)
    root_path
  end

  def user_admin?
    unless current_user.admin?
      flash[:danger] = I18n.t("security.not_allowed")
      redirect_to(root_url)
    end
  end
end
