require 'spec_helper'

describe "Invites" do
  before { [User].each &:destroy_all }
  
  describe "inviting a person" do
    context "when logged in" do
      before do
        user = FactoryGirl.create(:user)
        visit new_session_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Login"

        visit new_invite_path
      end

      context "with a valid email address" do
        it "should create an invitation record" do
          fill_in "Email", :with => 'valid@email.address'
          expect{ click_button "Send Invite" }.to change{ Invite.count }.by(1)
          page.should have_content "Invitation sent"
        end

        it "should deliver an email" do
          fill_in "Email", :with => 'valid@email.address'
          expect{ click_button "Send Invite" }.to change{ InviteMailer.deliveries.count }.by(1)
        end
      end

      context "with an invalid email address" do
        it "should re-render the form with errors" do
          fill_in "Email", :with => 'invalid@emailaddress'
          expect{ click_button "Send Invite" }.to change{ Invite.count }.by(0)
          page.should have_content "Invalid email"
        end
      end
    end

    context "when logged out" do
      it "should redirect to session#new" do
        visit new_invite_path
        current_path.should eql(new_session_path)
        page.should have_content "You must login"
      end
    end
  end
end