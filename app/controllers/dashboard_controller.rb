class DashboardController < ApplicationController
	before_action :authenticate_user!

	def index
    gon.is_admin = current_user.admin?
  end
end
