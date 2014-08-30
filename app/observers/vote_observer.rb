require "active_support"

class VoteObserver < ActiveRecord::Observer

  def after_create(vote)
     vote.voteable_type.constantize.increment_counter(:votes_count, vote.voteable_id)
  end

  def after_save(vote)
    voteable = vote.voteable_type.constantize.find(vote.voteable_id)
    question_id = 0

    if voteable.class == Question
      question_id = voteable.id
    else
      question_id = voteable.question.id
    end

    data = {
        question_id: question_id,
        voteable_type: voteable.class.to_s.downcase
    }
    activity = ActivityBuilder.new.build(vote, data, 'create_vote', voteable.user)

    if voteable.class == Question
      award_question_voted_bonus!(voteable.user)
      activity.points = QUESTION_VOTED_BONUS
    else
      award_answer_voted_bonus!(voteable.user)
      activity.points = ANSWER_VOTED_BONUS
    end

    activity.save
  end

  def after_destroy(vote)
    vote.voteable_type.constantize.decrement_counter(:votes_count, vote.voteable_id)

    voteable = vote.voteable_type.constantize.find(vote.voteable_id)

    if voteable.class == Question
      retract_question_voted_bonus!(voteable.user)
    else
      retract_answer_voted_bonus!(voteable.user)
    end


  end

  private

  def award_question_voted_bonus!(user)
    user.add_points(QUESTION_VOTED_BONUS)
  end

  def retract_question_voted_bonus!(user)
    user.deduct_points(QUESTION_VOTED_BONUS)
  end

  def award_answer_voted_bonus!(user)
    user.add_points(ANSWER_VOTED_BONUS)
  end

  def retract_answer_voted_bonus!(user)
    user.deduct_points(ANSWER_VOTED_BONUS)
  end



end
