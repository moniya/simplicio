class Relationship < ActiveRecord::Base
  attr_accessible :user, :follow, :follow_id
  belongs_to :user
  belongs_to :follow, :class_name => "User"

  validates :user_id, uniqueness: {scope: :follow_id, message: "You already follow this person."}
end
