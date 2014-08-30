class AnswerObserver < ActiveRecord::Observer

  def after_create(answer)
    Post.increment_counter(:answers_count, answer.question_id)
  end

  def after_save(answer)
    data = {
        question_title: answer.question.title,
        question_id: answer.question.id,
        answer_id: answer.id,
        answer_excerpt: answer.text.truncate(160, :separator => ' '),
    }
    activity = ActivityBuilder.new.build(answer, data, 'create_answer', answer.question.user)
    award_new_answer_bonus!(answer.user)

    activity.points = ANSWER_BONUS
    activity.save
  end

  def after_destroy(answer)
    retract_new_answer_bonus!(answer.user)
    Post.decrement_counter(:answers_count, answer.question_id)
  end

  private

  def award_new_answer_bonus!(user)
    user.add_points(ANSWER_BONUS)
  end

  def retract_new_answer_bonus!(user)
    user.deduct_points(ANSWER_BONUS)
  end

end
