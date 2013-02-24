require "spec_helper"

describe "Users" do
  describe "signing up" do
    let(:user) { FactoryGirl.build(:user) }
    before { visit new_users_path }

    context "with valid information" do
      before do
        fill_in_signup_form(user.email, user.password)
      end

      it "should create a new user account" do
        expect { click_button "Sign Up" }.to change{ User.count }.by(1)
        current_path.should eql(root_path)
        page.should have_content "You signed up!"
      end
    end

    context "with invalid information" do
      before do
        fill_in_signup_form('lawson', user.password)
      end

      it "should not create a new user account" do
        expect { click_button "Sign Up" }.to change{ User.count }.by(0)
        page.should have_content "There were errors"
      end
    end
  end

  describe "redeeming an invitation" do
    let(:invite) { Invite.create(:email => 'valid@email.address', :user_id => 1) }
    before { visit "/redeem_invite/#{invite.code}" }

    it "should autofill the email field" do
      find_field("Email").value.should eql(invite.email)
    end
  end 
end

def fill_in_signup_form(email, password)
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
end