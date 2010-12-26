require 'spec_helper'

describe Api::LangsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, Api::LangsController)
    end
    
    describe "index" do
      it "should be successful" do
        get(api_langs_path)
        response.should be_successful
      end
    end
  end

  context "not logged in user" do
    it "should show login form" do
      get(api_langs_path)
      response.status.should == 401
    end
  end
end