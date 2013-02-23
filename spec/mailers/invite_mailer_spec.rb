require 'spec_helper'
include EmailSpec::Helpers
include EmailSpec::Matchers

describe InviteMailer do
  describe "#invite" do

    let(:invite) { Invite.create(:email => 'valid@email.address', :user_id => 1) }
    subject { InviteMailer.invite(invite) }
    
    it { should deliver_to invite.email }

    it "has the correct subject" do
      should have_subject "Invite to App"
    end

    it "contains a signup link" do
      should have_body_text /#{invite.code}/
    end
  end
end