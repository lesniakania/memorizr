require 'spec_helper'

describe SessionsController do
  describe "new" do
    it "should render login form properly" do
      get(new_session_path)
      response.should be_successful
    end
  end

  describe "create" do
    before(:each) do
      @password = 'ala123'
      @user = Factory.create(:user, :password => @password)
    end

    it "should authenticate properly with valid data given" do
      session = {}
      SessionsController.any_instance.stubs(:session).returns(session)
      
      params = {
        :session_form => {
          :email => @user.email,
          :password => @password
        }
      }
      post(session_path, params)
      response.should redirect_to(root_path)
      session[:user_id].should_not be_nil
    end

    it "should render login form when invalid data given" do
      params = {
        :session_form => {
          :email => @user.email,
          :password => 'invalid-password'
        }
      }
      post(session_path, params)
      response.status.should == 409
      response.should render_template('new')
    end
  end

  describe "logout" do
    it "should logout user properly" do
      session = {
        :user_id => 7
      }
      SessionsController.any_instance.stubs(:session).returns(session)
      get(logout_session_path)
      response.should redirect_to(root_path)
      session[:user_id].should be_nil
    end
  end
end