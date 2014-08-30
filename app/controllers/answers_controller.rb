class AnswersController < ApplicationController
  respond_to :html, :json, :js

  load_and_authorize_resource :question
  load_and_authorize_resource :answer, :through => :question

  def index
    q_id = params[:question_id].to_i
    time_at = Time.at(params[:after].to_i + 1)
    c_user = current_user
    @answers = Answer.where{question_id.eq(q_id) & (created_at > time_at) & (user_id != c_user.id) }
  end

  def create
    @answer.user = current_user
    @answer.save

    respond_with([@question, @answer]) do |format|
      expire_action action: :index, controller: :questions

      format.html { redirect_to @question, notice: 'Answer was posted successfully.' }
      format.js { error_alert(@answer) if @answer.errors.any? }
    end
  end
end
