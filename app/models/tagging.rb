class Tagging < ActiveRecord::Base
  attr_accessible :question_id, :tag_id, :tag
  belongs_to :question
  belongs_to :tag, :counter_cache => true

  validates_uniqueness_of :tag_id, :scope => :question_id


end
