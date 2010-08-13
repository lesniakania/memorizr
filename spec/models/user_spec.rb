require 'spec_helper'

describe User do
  describe "validations" do
    before(:each) do
      @user = Factory.build(:user)
    end

    it "should be valid" do
      @user.should be_valid
    end

    it "should not be valid without email" do
      @user.email = nil
      @user.should_not be_valid
    end

    it "should not be valid with email in not valid format" do
      @user.email = 'not-valid-email'
      @user.should_not be_valid
    end

    it "should not be valid without password" do
      @user.password = nil
      @user.should_not be_valid
    end
  end

  describe "instance methods" do
    before(:each) do
      @user = Factory.create(:user)
    end

    it "should clear password properly" do
      @user.password = "password"
      @user.clear_password
      @user.password.should be_nil
      @user.encrypted_password.should be_nil
    end

    it "should clear password when nil given" do
      @user.password = "password"
      @user.password = nil
      @user.password.should be_nil
      @user.encrypted_password.should be_nil
    end

    it "should clear password when empty string given" do
      @user.password = "password"
      @user.password = ""
      @user.password.should be_nil
      @user.encrypted_password.should be_nil
    end
  end
end