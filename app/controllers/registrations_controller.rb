class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!

  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
