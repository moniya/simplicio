class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password,
                  :password_confirmation, :remember_me,
                  :department, :bio, :avatar, :school

  validates :first_name, :last_name, presence: true

  belongs_to :level
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
  has_many :activities, dependent: :destroy
  has_many :received_activities, :class_name => "Activity", :foreign_key => :recipient_id
  has_many :relationships, dependent: :destroy
  has_many :follows, :through => :relationships
  has_many :follower_relationships, :class_name => "Relationship", :foreign_key => :follow_id
  has_many :followers, :through => :follower_relationships, :source => :user
  has_many :views
  has_many :viewed_questions, through: :views, source: :question

  mount_uploader :avatar, AvatarUploader

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_voted?(post)
    post.votes.map(&:user_id).include?(self.id)
  end

  def fresh_view?(question)
    last_view = self.views.order('created_at DESC').where("question_id = ?", question.id).first
    Rails.logger.info("======================view call???????==================")
    first_view?(last_view) || repeatable_view?(last_view)
  end

  def self.top_users
    order('score DESC').limit(10)
  end

  def repeatable_view?(last_view)
    last_view.created_at < 10.seconds.ago
  end

  def first_view?(last_view)
    !last_view
  end

  def new_notifications
    notifications.where{created_at > my{self}.last_notification}
  end

  def notifications
    received_activities.where{user_id != my{self}.id}
  end

  def add_points(new_points)
    update_score_and_level(new_points)
  end

  def award_badge(name)
    badge = Badge.find_by_name(name)
    unless self.achievements.find_by_badge_id(badge.id)
      self.achievements.create(:badge => badge)
    end
  end

  def deduct_points(points_to_deduct)
    add_points(-points_to_deduct)
  end

  private

  def update_score_and_level(new_points)
    new_score = self.score += new_points.to_i
    self.update_attribute(:score, new_score)
    new_level = Level.find_level_for_score(new_score)
    if new_level && (!self.level || new_level.number > self.level.number)
      self.update_attribute(:level_id, new_level.id)
    end
  end

end
