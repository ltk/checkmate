class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:user][:email], params[:user][:password])
      self.current_user = user
      redirect_to user_path(user), :notice => "Signed in"
    else
      redirect_to new_session_path, :alert => "Couldn't find a user with those credentials"
    end
  end

  def destroy
    self.current_user = nil
    redirect_to new_session_path, :alert => "Signed out"
  end
end