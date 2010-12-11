require 'spec_helper'

describe LangsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, LangsController)
    end

    describe "index" do
      it "should be acceptable only for json" do
        get(langs_path, :format => 'html')
        response.status.should == 406
        get(langs_path, :format => 'json')
        response.should be_successful
      end
    end
  end

  context "not logged in user" do
    it "should show login form" do
      get(langs_path)
      response.should be_forbidden
    end
  end
end