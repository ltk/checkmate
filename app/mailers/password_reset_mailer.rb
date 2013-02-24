class PasswordResetMailer < ActionMailer::Base
  def send_reset_instructions(user)
    @user = user
    subject = "Reset Your Password"
    recipient = user.email
    mail(:to => recipient, :subject => subject)
  end
end