class InviteMailer < ActionMailer::Base
  def invite(invite)
    @code = invite.code
    subject = "Invite to App"
    recipient = invite.email
    mail(:to => recipient, :subject => subject)
  end
end