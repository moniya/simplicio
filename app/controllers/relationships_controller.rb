class RelationshipsController < ApplicationController
  respond_to :html, :json, :js

  def create
    @relationship = current_user.relationships.create(:follow_id => params[:follow_id])
    @follow = User.find(params[:follow_id])
    respond_with(@relationship) do |format|
      format.js {
        error_alert(@relationship) if @relationship.errors.any?
      }
    end
  end

  def remove
    f_id = params[:follow_id]
    @relationship = current_user.relationships.where{(follow_id == f_id)}.first
    @relationship.destroy
  end
end

