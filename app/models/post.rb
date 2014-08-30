class Post < ActiveRecord::Base
  attr_accessible :text, :user

  validates :text, :user, :presence => true
  validates :text, :length => {:minimum => 20}

  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.popular
  	where{ type == 'Question' }.order('votes_count DESC').limit(20)
  end
end
