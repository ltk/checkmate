require "spec_helper"

describe "Sessions" do
  describe "signing in" do
    before { visit new_session_path }

    context "with valid credentials" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Login"
      end

      it "should display a success message" do
        page.should have_content "Signed in"
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
end