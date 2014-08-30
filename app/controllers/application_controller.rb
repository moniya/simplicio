class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :notifications

  rescue_from CanCan::AccessDenied do
    respond_with([@question, @answer]) do |format|
      format.js { render :json => {message: "You do not have enough reputation points to perform this action."}, :status => "401" }

    end
  end

  def error_alert(instance)
    render(json: {message: format_error_message(instance)}, :status => "422")
  end

  private

  def format_error_message(instance)
    temp = []
    instance.errors.each do |attr, message|
      attr = "" if attr =~ /_id/ || attr == :base
      temp << "#{attr.capitalize} #{message}"
    end
    temp.join("\n\n")
  end

  def notifications
    @notifications, @new_notifications = current_user.notifications, current_user.new_notifications unless current_user.nil?
  end
end
