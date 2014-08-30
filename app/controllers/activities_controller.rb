class ActivitiesController < ApplicationController
  respond_to :html, :json, :js

  def index
    @activities = Activity.feed current_user
    @popular_posts = Post.popular
    respond_with @activities
  end

  def more
    last_time = Time.at(params[:last_timestamp].to_i)
    @activities = Activity.more_feed current_user, last_time
    respond_with @activities
  end

end