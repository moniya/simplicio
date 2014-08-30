class VotesController < ApplicationController
  respond_to :js

  load_resource :question
  load_resource :answer
  load_resource :comment
  load_and_authorize_resource :vote, :through => [:question, :answer, :comment]

  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do
    respond_with([@question, @answer]) do |format|
      format.js { render :json => { message: "You need at least 15 points to vote."}, :status => "401" }

    end
  end

  def create
    @vote.user = current_user
    @vote.save
    invalidate_caches

    respond_with(@vote) do |format|
      format.js {
          error_alert(@vote) if @vote.errors.any?
      }
    end
  end

  private
  def invalidate_caches
    @vote.voteable.touch
    expire_action action: :index, controller: :questions
  end
end
