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
end
