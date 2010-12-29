require 'spec_helper'

describe UserWord do
  before(:each) do
    @user = Factory.create(:user)
    @word = Factory.create(:word, :lang => @en)
    @user_word = UserWord.create(:user => @user, :word => @word)
  end

  it "should have lang_id" do
    @user_word.lang_id.should == @user_word.word.lang_id
  end

  it "should have position in scope [:user_id, :lang_id]" do
    word = Factory.create(:word, :lang => @pl)
    user_word = UserWord.create(:user => @user, :word => word)
    @user_word.position.should == 1
    user_word.position.should == 1
  end
end