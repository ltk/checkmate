class ApplicationController < ActionController::Base
  include SimplestAuth::Controller
  protect_from_forgery

  private

  def ensure_logged_in
    unless logged_in?
      redirect_to new_session_path, :alert => "You must login first"
    end
  end
end
