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
end
