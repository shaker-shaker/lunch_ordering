class UsersController < ApplicationController
	before_action :authenticate_user!

	def edit
	end

	def update
		if current_user.update_attributes(user_params)
			flash[:info] = "Profile updated"
			redirect_to root_url
		else
			flash[:danger] = "Can't update profile"
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name)
	end
end
