class QuestionsController < ApplicationController
  respond_to :html, :js
  caches_action :index, layout: false

  def index
    @questions = Question.paged
    @top_users = User.top_users
    @top_tags = Tag.order('taggings_count DESC').limit 20
    respond_with(@questions)
  end

  def more
    @questions = Question.more(params[:last_timestamp])
    respond_with(@questions)
  end

  def show
    @question = Question.find(params[:id])

    if stale?(last_modified: @question.updated_at, etag: @question.class.to_s + @question.id.to_s + current_user.id.to_s)
      respond_with(@question) do |format|
        format.html {
          if request.path != question_path(@question)
            redirect_to question_path(@question, anchor: params[:hash]), status: :moved_permanently
          else
            render
          end
        }
      end
    end
  end

  def create
    @question = current_user.questions.create(params[:question])
    @question.tag!(params[:tags]) unless params[:tags].blank?
    expire_action :action => :index
    respond_with(@question)
  end
end
