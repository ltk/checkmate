class PasswordsController < ApplicationController
  def new
  end

  def create
    # TODO add email index to users table
    user = User.find_by_email(params[:email])

    if user
      user.set_password_reset_token
      PasswordResetMailer.send_reset_instructions(user).deliver
      redirect_to root_path, :notice => "Check your email for reset instructions"
    else
      flash.now[:error] = "No user was found for the given email address"
      render :new
    end
  end
end