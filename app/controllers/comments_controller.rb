class CommentsController < ApplicationController
  respond_to :html, :json, :js
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do
    respond_with(@comment) do |format|
      format.js { render :json => {message: "You need at least 50 points to post comments."}, :status => "401" }

    end
  end

  def index
    answer_ids = params[:answer_ids].split(',').map(&:to_i)
    time_at = Time.at(params[:after].to_i + 1)
    c_user = current_user
    @comments = Comment.where { post_id.in(answer_ids) & (created_at > time_at) & (user_id != c_user.id) }
  end

  def create
    @answer = Answer.includes([:user, :question]).find params[:answer_id]
    Rails.cache.write("user_#{current_user.id}_current_answer", @answer)

    @comment = @answer.comments.build(params[:comment].merge!({:user => current_user}))
    authorize! :create, @comment
    @comment.save
    respond_with [@answer, @comment] do |format|
      format.html { redirect_to @answer.question, notice: 'Comment was posted successfully.' }

    end
  end
end
