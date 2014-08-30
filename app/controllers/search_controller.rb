class SearchController < ApplicationController
  respond_to :html, :json

  def index
    if  params[:query]
      @questions = Question.search(params[:query])
    else
      @questions = Question.all
    end
    @top_users = User.top_users

    respond_with @questions
  end
end
