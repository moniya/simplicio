class Answer < Post
  attr_accessible :question

  belongs_to :question, touch: true
  validates_uniqueness_of :user_id, :scope => :question_id,
                          :message => "You cannot answer the same question more than once, you should update your existing answer or post a comment."
  validate :sans_soliloquy
  default_scope order('votes_count DESC, created_at ASC')

  def sans_soliloquy
    if user_id == self.question.user_id
      errors[:base] << "You cannot answer your own question."
    end
  end
end
