require "spec_helper"

describe "Sessions" do
  before { [User].each &:destroy_all }
  
  describe "signing in" do
    before { visit new_session_path }

    context "with valid credentials" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Login"
      end

      it "should redirect to account page and display a success message" do
        page.should have_content "Signed in"
        current_path.should eql(user_path(user))
      end
    end

    context "with invalid credentials" do
      let(:user) { FactoryGirl.build(:user) }
      
      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Login"
      end

      it "re-renders the form with errors" do
        current_path.should eql(new_session_path)
        page.should have_content "Couldn't find a user"
      end
    end
  end

  describe "signing out" do
    describe "a user who is logged in" do
      it "should be able to log out" do
        user = FactoryGirl.create(:user)
        visit new_session_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Login"

        visit root_path
        click_link "Logout"

        page.current_path.should eql(new_session_path)
        page.should have_content "Signed out"
      end
    end
  end
end