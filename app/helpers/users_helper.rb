module UsersHelper
  def follow_links
    if @user.followers.include?(current_user)
      link_to "Unfollow #{@user.full_name}",
              "#",
              id: "follow-btn",
              class: "btn btn-danger",
              data: {action: :unfollow} unless current_user == @user
    else
      link_to "Follow #{@user.full_name}",
                    "#",
                    id: "follow-btn",
                    class: "btn btn-success",
                    data: {action: :follow} unless current_user == @user
    end
  end

end
