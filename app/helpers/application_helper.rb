module ApplicationHelper

  def badge_color(current_user, post)
    if current_user.has_voted?(post)
      "badge-voted"
    else
      "badge-inverse"
    end
  end


  def title text
    content_for(:title) { text }
  end

end

