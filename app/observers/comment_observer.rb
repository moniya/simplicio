class CommentObserver < ActiveRecord::Observer
  def after_save(comment)
    post = Rails.cache.read("user_#{comment.user.id}_current_answer") || comment.post
    data = {
            question_id: post.type == 'Question' ? post.id : post.question.id,
            comment_id: comment.id,
            post_type: post.type.downcase
    }
    activity = ActivityBuilder.new.build(comment, data, 'create_comment', post.user)
    activity.save
    Rails.cache.delete "user_#{comment.user.id}_current_answer"

  end

end
