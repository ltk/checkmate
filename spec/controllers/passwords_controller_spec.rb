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
        post :create, :user => { :email => user.email }
        PasswordResetMailer.deliveries.last.to.should eql([user.email])
      end

      it "redirects to the root path" do
        post :create, :user => { :email => user.email }
        page.should redirect_to "/"
      end

      it "displays a flash message" do
        post :create, :user => { :email => user.email }
        flash[:notice].should == "Check your email for reset instructions"
      end
    end

    context "with an unkown email address" do
      it "re-renders the reset form" do
        post :create, :user => { :email => "unknown@email.address" }
        page.should render_template(:new)
      end
    end
  end

  describe "#edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { user.set_password_reset_token }

    context "with a valid reset token" do
      it "should display the reset form" do
        get :edit, :user_id => user.id, :token => user.password_reset_token
        page.should render_template(:edit)
      end
    end

    context "with an invalid reset token" do
      it "should redirect to the reset request form" do
        get :edit, :user_id => user.id, :token => 'invalid-token'
        response.should redirect_to(new_password_path)
      end
    end
  end
end