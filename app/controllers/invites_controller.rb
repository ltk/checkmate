class InvitesController < ApplicationController
  before_filter :ensure_logged_in
  
  def new
  end

  def create
    invite = Invite.new(params[:invite])
    invite.user = current_user
    if invite.save
      redirect_to root_path, :notice => "Invitation sent"
    else
      flash.now[:error] = "Invalid email address. Try again."
      render "new"
    end
  end
end