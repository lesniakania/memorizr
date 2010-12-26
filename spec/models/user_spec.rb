require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory.create(:user)
  end

  describe "validations" do
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

    it "should not be valid with email not unique" do
      @user.save
      user = Factory.build(:user, :email => @user.email)
      user.should_not be_valid
    end
  end

  describe "password methods" do
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

  describe "words_by_languages" do
    it "should retrieve only users words" do
      @word = Factory.create(:word, :lang => @en)
      @meaning = Factory.create(:word, :lang => @pl)
      @word.meanings << @meaning
      @word.save
      @user.words += [@word, @meaning]
      @user.save

      word = Factory.create(:word, :lang => @en)
      meaning = Factory.create(:word, :lang => @pl)
      word.meanings << meaning
      word.save
      user = Factory.create(:user)
      user.words += [word, meaning]
      user.save

      words = @user.words_by_languages(@en, @pl)
      words.should include(@word)
      words.should_not include(word)
    end

    it "should be able to filter words" do
      hr = Factory.create(:lang, :value => 'hr')

      en_word1 = Factory.create(:word, :lang => @en, :value => 'en_word1')
      en_word2 = Factory.create(:word, :lang => @en, :value => 'en_word2')
      pl_word = Factory.create(:word, :lang => @pl, :value => 'pl_word')
      hr_word = Factory.create(:word, :lang => hr, :value => 'hr_word')

      @user.words += [en_word1, en_word2, pl_word, hr_word]
      @user.save

      en_word1.meanings += [pl_word, hr_word]
      en_word1.save

      en_word2.meanings << hr_word
      en_word2.save

      words = @user.words_by_languages(@en, @pl)
      en_word1.reload
      words.should include(en_word1)
      words.should_not include(en_word2)
    end
  end
end