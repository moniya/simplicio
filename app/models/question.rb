class Question < Post
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :title
  validates :title, uniqueness: true, length: {:within => 20..160}

  has_many :answers, dependent: :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :views, :dependent => :destroy

  default_scope order('created_at DESC')

  def self.included_find(id)
    includes(:answers => [:user, {:comments => :user}]).find(id)
  end

  def self.find_and_register_impression(id, current_user)
    question = included_find(id)
    if can_register_view(current_user, question)
      View.create(user: current_user, question: question)
      Post.increment_counter :views_count, question.id
    end

    question
  end

  def contributors
    comments =  self.answers.map(&:comments).flatten
    (comments.map(&:user) << self.answers.map(&:user) << self.user).flatten.uniq
  end

  def related
    self.class.joins{taggings.tag}.where{(tags.id >> my{tag_ids})}.reject{|q| q == self}.uniq
  end

  def self.can_register_view(current_user, question)
    current_user.fresh_view?(question) && question.user != current_user
  end

  def tag!(tags)
    #new_tags = tags.split(",").map(&:strip) - self.tags.map(&:name)
    #new_tags2 = self.tags.map(&:name)  - tags.split(",").map(&:strip)
    # return if new_tags.empty? && new_tags2.empty?

    taggings = tags.downcase.strip.split(",").map do |name|
      tag = Tag.find_or_create_by_name(name.strip)
      Tagging.find_or_initialize_by_tag_id_and_question_id(question_id: self.id, tag_id: tag.id)
    end

    self.taggings << taggings
  end

  def self.paged
    includes(:user).limit(10)
  end

  def self.more(last_timestamp)
    time_at = Time.at(last_timestamp.to_i)
    where('created_at < ?', time_at).includes(:user).limit(10)
  end

  def self.search(query)
    if query =~ /^tag:/
      search_by_tag(query)
    else
      where{title.matches("%#{query}%") | text.matches("%#{query}%")}
    end
  end

  private

  def self.search_by_tag(query)
    tag = Tag.where(:name => query.gsub(/^tag:/, "")).first
    return [] if tag.nil?
    tag.questions
  end
end