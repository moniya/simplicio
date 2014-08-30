module ActivitiesHelper
  def actor_link(activity)
    if activity.user_id == current_user.id
      link_to "You", user_path(activity.user_id), class: "user-link"
    else
      link_to activity.username, user_path(activity.user_id), class: "user-link"
    end
  end

  def recipient_link(activity)
    if activity.recipient.full_name == current_user.full_name
      link_to "You", user_path(activity.recipient.id), class: "user-link"
    else
      link_to activity.recipient.full_name, user_path(activity.recipient.id), class: "user-link"
    end
  end

  def feed_image(activity)
    image_tag activity.user.avatar.small_thumb.url, :alt => "" unless activity.user_id == current_user.id

  end

  def follow_message(activity)
    action_text = ""
    if activity.user_id == current_user.id
      action_text = "follow"
    else
      action_text = "follows"
    end

    actor_link(activity) + " now #{action_text} "+  recipient_link(activity)
  end
end