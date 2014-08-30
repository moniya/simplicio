class NotificationsController < ApplicationController
  def index
    current_user.last_notification = Time.now
    current_user.save
  end
end
