class Comment < ActiveRecord::Base
  attr_accessible :text, :user
  belongs_to :user
  belongs_to :post, touch: true
  has_many :votes, :as => :voteable

  default_scope order('created_at ASC')

  validates :text, :presence => true
end
