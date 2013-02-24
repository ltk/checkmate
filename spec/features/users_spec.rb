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
        current_path.should eql(user_path(User.last.id))
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

    context "with a new valid email address" do
      it "should be able to change email address" do
        fill_in "Email", :with => "new@email.address"
        click_button "Update Information"

        current_path.should eql("/users/#{user.id}/edit")
        page.should have_content "Information updated"
        user.reload.email.should eql("new@email.address")
      end
    end

    context "with a new invalid email address" do
      before do
        fill_in "Email", :with => "invalid@email"
        click_button "Update Information"
      end

      it "should re-render the edit form with an error message" do
        page.should have_content "There were errors"
        current_path.should eql("/users/#{user.id}/edit")
      end

      it "should not change email address" do
        old_email = user.email
        old_email.should eql(user.reload.email)
      end
    end

    context "with a new password" do
      before { fill_in "user_password", :with => 'new-password' }

      context "with a matching password confirmation" do
        it "should update the crypted password" do
          fill_in "user_password_confirmation", :with => 'new-password'
          click_button "Update Information"
          old_crypt_pass = user.crypted_password
          old_crypt_pass.should_not eql(user.reload.crypted_password)
        end
      end

      context "with a non-matching password confirmation" do
        it "should not update the crypted password" do
          fill_in "user_password_confirmation", :with => 'major-typo'
          click_button "Update Information"
          old_crypt_pass = user.crypted_password
          old_crypt_pass.should eql(user.reload.crypted_password)
        end
      end
    end
  end

  describe "viewing profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit "/users/#{user.id}"}

    it "should contain their email address" do
      page.should have_content user.email
    end

    it "should contain their avatar img" do
      page.should have_xpath("//img[@src=\"#{user.avatar_url}\"]")
    end
  end  
end

def fill_in_signup_form(email, password)
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
end