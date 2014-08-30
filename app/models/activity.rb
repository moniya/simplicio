class Activity < ActiveRecord::Base
  attr_accessible :user_id, :username, :kind, :data, :recipient
  belongs_to :user
  belongs_to :recipient, class_name: "User"

  default_scope order('created_at DESC')
  serialize :data, ActivityDataSerializer.new

  def to_partial_path
    "activities/#{kind}"
  end

  def self.feed current_user
  	where {
      (user_id == my { current_user }.id) |
          (recipient_id == my { current_user }.id) |
          (user_id >> my { current_user }.follow_ids)
    }.limit 10
  end

  def self.more_feed current_user, last_time
  	where {
      ((user_id == my { current_user }.id) & (created_at.lt(last_time))) |
          ((recipient_id == my { current_user }.id) & (created_at.lt(last_time))) |
          ((user_id >> my { current_user }.follow_ids) & (created_at.lt(last_time)))
    }.limit 10
  end
end
