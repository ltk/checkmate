require "spec_helper"

describe "Users" do
  describe "signing up" do
    let(:user) { FactoryGirl.build(:user) }
    before { visit new_user_path }

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
  
  describe "editing own information" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit "/users/#{user.id}/edit"}

    context "with valid information" do
      it "should be able to change email address" do
        fill_in "Email", :with => "new@email.address"
        click_button "Update Information"

        current_path.should eql("/users/#{user.id}/edit")
        page.should have_content "Information updated"
        user.reload.email.should eql("new@email.address")
      end
    end

    context "with invalid information" do
      before do
        fill_in "Email", :with => "invalid@email"
        click_button "Update Information"
      end

      it "should re-render the edit form with an error message" do
        page.should have_content "There were errors"
        current_path.should eql("/users/#{user.id}/edit")
      end

      it "should not change information" do
        old_email = user.email
        old_email.should eql(user.reload.email)
      end
    end
  end   
end

def fill_in_signup_form(email, password)
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
end