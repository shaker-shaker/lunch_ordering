module UsersHelper

  def user_list
    redirect_to(root_url) unless current_user.admin?
    render partial: "users/user_list_tab", 
            locals: { users: User.where("id != ?", current_user.id) }
  end
end
