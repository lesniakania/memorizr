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
    before(:each) do
      @user = Factory.create(:user)
      @lang = Factory.create(:lang)
      @word = 'word1'
      @meanings = ['m1', 'm2']
    end

    it "should save word with it's meanings properly" do
      Word.save_with_meanings(@user, @word, @lang.value, @lang.value, @meanings)
      saved_word = Word.first(:value => @word)
      saved_word.should_not be_nil
      @meanings.each { |m| Word.first(:value => m).should_not be_nil }
      Set.new(saved_word.meanings.map(&:value)).should == Set.new(@meanings)
    end

    it "should return false if invalid data given" do
      Word.save_with_meanings(@user, @word, @lang.value, nil, @meanings)
      saved_word = Word.first(:value => @word)
      saved_word.should be_nil
      @meanings.each { |m| Word.first(:value => m).should be_nil }
    end
  end
end