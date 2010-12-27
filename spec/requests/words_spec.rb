require 'spec_helper'

describe WordsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, WordsController)
    end

    describe "index" do
      before(:each) do
        @user.expects(:words_by_languages).returns([])
      end

      it "should show only current users words" do
        get(words_path)
        response.should be_successful
      end

      it "should be able to filter words" do
        get(words_path, { :from => @en.id, :to => @pl.id })
        response.should be_successful
      end
    end

    describe "new" do
      it "should render translate form properly" do
        get(new_word_path)
        response.should be_successful
      end
    end

    describe "translate" do
      before(:each) do
        @params = {
          :word => {
            :value => 'word',
            :lang => @en.id,
            :to => @pl.id
          }
        }
      end

      it "should render results properly" do
        @meanings = (1..2).map { |m| Factory.create(:word, :lang => @pl) }
        Word.any_instance.stubs(:extract_meanings).returns(@meanings)
        post(translate_words_path, @params)
        response.should be_successful
        @meanings.each { |m| response.body.should include(m.value.to_s) }
      end

      it "should render translate form if any error appears during translation" do
        Net::HTTP.stubs(:get_response).raises('error')
        post(translate_words_path, @params)
        response.status.should == 409
      end
    end

    describe "save" do
      before(:each) do
        lang = Factory.create(:lang)
        @params = {
          :word => 'word1',
          :from_id => lang.id,
          :to_id => lang.id,
          :meanings => ['word2']
        }
      end

      it "should save words with meanings when valid data given" do
        post(save_words_path, @params)
        response.should be_successful
      end

      it "should render translate form when invalid data given" do
        @params[:word] = nil
        post(save_words_path, @params)
        response.status.should == 409
      end
    end

    describe "destroy" do
      before(:each) do
        @word = Factory.create(:word)
        @user.words << @word
        @user.save
      end

      it "should destroy user word successfully" do
        delete(word_path(@word))
        response.should be_successful
        @user.reload.words.first(:value => @word.value).should be_nil
        Word.first(:value => @word.value, :lang => @word.lang).should_not be_nil
      end

      it "should handle error properly" do
        UserWord.any_instance.stubs(:destroy).returns(false)
        delete(word_path(@word))
        response.status.should == 409
      end
    end
  end

  context "not logged in user" do
    it "should show login form" do
      [words_path, new_word_path].each do |path|
        get(path)
        response.should be_forbidden
      end

      [translate_words_path, save_words_path].each do |path|
        post(path)
        response.should be_forbidden
      end
    end
  end
end
