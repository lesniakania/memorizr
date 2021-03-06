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

    it "should unique in lang scope" do
      @word.save
      word = Factory.build(:word, :value => @word.value, :lang => @word.lang)
      word.should_not be_valid
    end
  end

  describe "save_with_meanings" do
    before(:each) do
      @user = Factory.create(:user)
      @word = 'word1'
      @meanings = ['m1', 'm2']
    end

    it "should save word with its meanings properly" do
      Word.save_with_meanings(@user, @word, @en.id, @pl.id, @meanings)
      word = Word.first(:value => @word)
      word.should_not be_nil
      Set.new(@user.reload.words.map(&:value)).should == Set.new(@meanings + [@word])
      Set.new(word.meanings.map(&:value)).should == Set.new(@meanings)
    end

    it "should return false if invalid data given" do
      Word.save_with_meanings(@user, @word, @en.id, nil, @meanings)
      saved_word = Word.first(:value => @word)
      saved_word.should be_nil
      @meanings.each { |m| Word.first(:value => m).should be_nil }
    end

    it "should not raise error while trying to save the same word again" do
      2.times { Word.save_with_meanings(@user, @word, @en.id, @pl.id, @meanings).should be_true }
    end

    it "should save translation the same word to the same word" do
      Word.save_with_meanings(@user, @word, @en.id, @en.id, [@word])
      Word.first(:value => @word).meanings.first(:value => @word).should_not be_nil
    end
  end

  describe "retrieving words and meanings" do
    before(:each) do
      @word = Factory.build(:word, :lang => @en)
      @meanings = [@en, @pl].map { |l| Factory.create(:word, :lang => l) }
      @word.meanings += @meanings
      @word.save

      @user = Factory.build(:user)
      @user.words += [@word] + @meanings
      @user.save
    end

    it "should retrieve words translated from a specific language to a specific language" do
      Set.new(@user.words_by_languages(@en, @pl)).should == Set.new([@word])
    end

    it "retieved words should be sorted by value" do
      Word.destroy
      words = ['b-word', 'c-word', 'a-word'].map { |v| Factory.build(:word, :value => v, :lang => @en) }
      
      meanings = words.map { |w| Factory.create(:word, :value => "pl-#{w.value}", :lang => @pl) }
      meanings.each_with_index do |m, i|
        words[i].meanings << m
        words[i].save
      end

      words.each { |word| @user.words << word }
      @user.save

      @user.words_by_languages(@en, @pl).map(&:value).should == ['a-word', 'b-word', 'c-word']
    end

    it "should retrieve meanings for a specific language" do
      Set.new(@word.meanings_to(@pl)).should == Set.new(@meanings[1..-1])
    end

    it "should retrieve meanings from database when they are there" do
      Translator.expects(:extract_meanings).times(0)
      Set.new(@word.extract_meanings(@en, @pl)).should == Set.new(@meanings[1..-1])
    end

    it "should retrieve meanings from google when they are not in database" do
      word = Factory.build(:word, :value => @word.value, :lang => @word.lang)
      @word.destroy
      Translator.expects(:extract_meanings).times(1).returns([])
      @word.extract_meanings(@en, @pl).should be_true
    end

    it "should not request google if invalid word given" do
      Translator.expects(:extract_meanings).times(0).returns([])
      word = Factory.build(:word)
      word.value = nil
      word.extract_meanings(@en, @pl).should be_false
    end
  end

  describe "hash format" do
    before(:each) do
      @word = Factory.build(:word, :lang => @en)
      @meanings = {
        :en => Factory.create(:word, :lang => @en),
        :pl => Factory.create(:word, :lang => @pl)
      }
      @word.meanings += @meanings.values
      @word.save

      @user = Factory.build(:user)
      @user.words += [@word] + @meanings.values
      @user.save
    end

    it "should not include meanings if include_meanings_to is not passed" do
      hash = @word.hash_format
      hash[:id].should == @word.id
      hash[:value].should == @word.value
      hash.should_not include(:meanings)
    end

    it "should include meanings if include_meanings_to is passed" do
      hash = @word.hash_format(@pl)
      hash[:id].should == @word.id
      hash[:value].should == @word.value
      hash[:lang_id].should == @word.lang_id
      hash.should include(:meanings)
      hash[:meanings].first[:id].should == @meanings[:pl].id
      hash[:meanings].first[:value].should == @meanings[:pl].value
      hash[:meanings].first[:lang_id].should == @meanings[:pl].lang_id
    end
  end
end
