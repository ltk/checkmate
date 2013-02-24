require "spec_helper"

describe User do
  before { [User].each &:destroy_all }
  let(:user) { FactoryGirl.create(:user) }

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should_not allow_value("lawson").for(:email) }
    it { should_not allow_value("lawson@lawson").for(:email) }
    it { should allow_value("lawson@lawson.com").for(:email) }
    it { should_not allow_value("1234").for(:password) }
    it { should allow_value("12345").for(:password) }
  end

  context "associations" do
    it { should have_many(:invites) }
  end

  describe "#set_password_reset_token" do
    it "should add a reset token" do
      user.set_password_reset_token
      user.password_reset_token.should match(/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/)
    end
  end
end