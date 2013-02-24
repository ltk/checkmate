class UsersController < ApplicationController
  def new
    if params[:code]
      invite = Invite.find_by_code(params[:code])
      @user = User.new(:email => invite.email)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "You signed up!"
    else
      flash.now[:error] = "There were errors with your submission"
      render "new"
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.assign_attributes(params[:user])
    if @user.save
      redirect_to edit_user_path(@user.id), :notice => "Information updated"
    else
      redirect_to edit_user_path(@user.id), :alert => "There were errors with your submission"
    end
  end
end
