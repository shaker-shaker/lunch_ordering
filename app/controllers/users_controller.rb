class UsersController < ApplicationController
  before_action :user_admin?

  def list
    @users = User.all
  end
end
