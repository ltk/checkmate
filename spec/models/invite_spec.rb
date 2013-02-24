require 'spec_helper'

describe Invite do
  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should allow_value('valid@email.address').for(:email) }
    it { should_not allow_value('invalid@email').for(:email) }
    it { should_not allow_value('invalid').for(:email) }
  end

  context "associations" do
    it { should belong_to(:user) }
  end

  context "respond to" do
    it { should respond_to(:generate_code) }
  end

  describe "#generate_code" do
    it "should execute callback upon creation" do
      invite = Invite.new(:email => 'valid@email.address', :user_id => 1)
      invite.should_receive(:generate_code)
      invite.save
    end

    it "should generate a hex hash code" do
      invite = Invite.create(:email => 'valid@email.address', :user_id => 1)
      invite.code.should == Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--valid@email.address--")
    end
  end
end
