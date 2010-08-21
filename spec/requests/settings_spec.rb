require 'spec_helper'

describe SettingsController do
  describe "change password" do
    context "logged in user" do
      before(:each) do
        @old_password = 'ala123'
        @user = Factory.create(:user, :password => @old_password, :password_confirmation => @old_password)
        login(@user, SettingsController)
      end

      it "should render edit password properly" do
        get(edit_password_settings_path)
        response.should be_successful
        response.should render_template('edit_password')
      end

      it "should change password successfully" do
        new_password = 'new-password'
        user = {
          :password => new_password,
          :password_confirmation => new_password
        }
        put(update_password_settings_path, :user => user)
        response.should redirect_to(edit_password_settings_path)
        @user.reload.password.should == new_password
      end

      it "should change password successfully" do
        new_password = 'new-password'
        user = {
          :password => new_password,
          :password_confirmation => 'wrong-confirmation'
        }
        put(update_password_settings_path, :user => user)
        response.status.should == 409
        response.should render_template('edit_password')
        @user.reload.password.should == @old_password
      end
    end

    context "not logged in user" do
      it "should render edit password properly" do
        get(edit_password_settings_path)
        response.should be_forbidden

        put(update_password_settings_path)
        response.should be_forbidden
      end
    end
  end
end