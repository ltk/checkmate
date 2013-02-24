require "spec_helper"

describe User do
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
end