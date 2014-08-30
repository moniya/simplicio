class QuestionObserver < ActiveRecord::Observer
  def before_save(question)
    question.slug = question.slug.mb_chars.limit(70).to_s
  end

  def after_save(question)
    data = {
        :question_title => question.title,
        :question_id => question.id,
        :excerpt => question.text
    }
    activity = ActivityBuilder.new.build(question, data, 'create_question')
    award_new_question_bonus!(question.user)
    activity.points = QUESTION_BONUS
    activity.save
  end

  def after_destroy(question)
    retract_new_question_bonus!(question.user)

    ActionController::Base.new.expire_page '/'
  end

  private

  def award_new_question_bonus!(user)
    user.add_points(QUESTION_BONUS)
  end

  def retract_new_question_bonus!(user)
    user.deduct_points(QUESTION_BONUS)
  end


end
