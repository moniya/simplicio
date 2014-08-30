class UserObserver < ActiveRecord::Observer
  def before_create(user)
    user.first_name.capitalize!
    user.last_name.capitalize!
  end

  def after_create(user)
    #Rails.logger.warn "User observed to be created!!!"
  end
end
