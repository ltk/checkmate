class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:user][:email], params[:user][:password])
      self.current_user = user
      redirect_to root_path, :notice => 'Signed in'
    else
      redirect_to new_session_path, :alert => "Couldn't find a user with those credentials"
    end
  end
end