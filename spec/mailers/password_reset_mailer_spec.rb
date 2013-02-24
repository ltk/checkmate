require 'spec_helper'
include EmailSpec::Helpers
include EmailSpec::Matchers

describe PasswordResetMailer do
  before { [User].each &:destroy_all }
  
  describe "#send_reset_instructions" do

    let(:user) { FactoryGirl.create(:user) }
    before { user.set_password_reset_token }
    subject { PasswordResetMailer.send_reset_instructions(user) }
    
    it { should deliver_to user.email }

    it "has the correct subject" do
      should have_subject "Reset Your Password"
    end

    it "contains a reset link" do
      should have_body_text /#{user.password_reset_token}/
    end
  end
end