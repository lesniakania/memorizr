require 'spec_helper'

describe Api::SessionsController do
  describe "create" do
    it "should authenticate properly with valid data given" do
      @user = Factory.create(:user)
      Api::SessionsController.any_instance.stubs(:basic_authenticate!).returns(true)
      Api::SessionsController.any_instance.stubs(:current_user).returns(@user)

      post(api_session_path)
      response.should be_successful
      user = JSON.parse(response.body)
      user.keys.should == ['id']
      user['id'].should == @user.id
    end

    it "should render login form when invalid data given" do
      post(api_session_path)
      response.status.should == 409
    end
  end

  describe "logout" do
    it "should logout user properly" do
      session = {
        :user_id => 7
      }
      Api::SessionsController.any_instance.stubs(:session).returns(session)
      get(logout_api_session_path)
      response.should be_successful
      session[:user_id].should be_nil
    end
  end
end