require 'spec_helper'

describe Word do
  describe "validations" do
    before(:each) do
      @word = Factory.build(:word)
    end

    it "should be valid" do
      @word.should be_valid
    end

    it "should not be valid without value" do
      @word.value = nil
      @word.should_not be_valid
    end

    it "should not be valid without lang" do
      @word.lang = nil
      @word.should_not be_valid
    end

    it "should not be valid without user" do
      @word.user = nil
      @word.should_not be_valid
    end
  end

  describe "save_with_meanings" do
    it "should save word with it's meanings properly" do
      user = Factory.create(:user)
      lang = Factory.create(:lang)
      word = 'word1'
      meanings = ['word2']
      Word.save_with_meanings(user, word, lang.value, lang.value, meanings)
      Word.first(:value => 'word1').should_not be_nil
      Word.first(:value => meanings.first).should_not be_nil
    end
  end
end