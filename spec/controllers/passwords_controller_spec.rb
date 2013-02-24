require 'spec_helper'

describe PasswordsController do
  before { [User].each &:destroy_all }
  
  describe "#new" do
    it "renders the password reset form" do
      get :new
      page.should render_template(:new)
    end
  end

  describe "#create" do
    context "with an email matching an existing user" do
      let(:user) { FactoryGirl.create(:user) }

      it "sends an email" do
        pending
        mailer = double("PasswordResetMailer", :deliver => true)
        PasswordResetMailer.should_receive(:send_reset_instructions).with(user).
          and_return(mailer)
        post :create, :email => user.email
      end

      it "redirects to the root path" do
        post :create, :email => user.email
        page.should redirect_to "/"
      end

      it "displays a flash message" do
        post :create, :email => user.email
        flash[:notice].should == "Check your email for reset instructions"
      end
    end
  end 
end