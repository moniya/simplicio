class Vote < ActiveRecord::Base
  attr_accessible :user
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :voteable_id, :scope => :user_id,
                            :message => "You've already voted up this post."
  validate :sans_soliloquy

   def sans_soliloquy
     if user_id == self.voteable.user_id
       errors[:base] << "You cannot vote up your own post."
     end
   end
end
