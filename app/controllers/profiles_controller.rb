class ProfilesController < ApplicationController
  respond_to :html, :json


  def show
    @user = current_user
    respond_with(@user) do |format|
      format.html { render "users/show" }
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    respond_with(@user) do |format|
      format.html{
        if @user.errors.count > 0
          render "edit"
        else
          redirect_to "/profile" , notice: "Your changes have been saved."
        end
      }
    end
  end
end
