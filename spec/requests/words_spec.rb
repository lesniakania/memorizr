require 'spec_helper'

describe WordsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, WordsController)
    end

    describe "index" do
      it "should show only current users words" do        
        @word = Factory.create(:word, :user => @user)
        user = Factory.create(:user)
        word = Factory.create(:word, :user => user)
        
        get(words_path)
        response.should be_successful
        response.body.should include(@word.value)
        response.body.should_not include(word.value)
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
            :lang => 'en',
            :to => 'pl'
          }
        }
      end

      it "should render results properly" do
        Translator.stubs(:retrieve_meanings).returns([])
        post(translate_words_path, @params)
        response.should be_successful
        response.should render_template('results')
      end

      it "should render translate form if any error appears during translation" do
        Translator.stubs(:retrieve_meanings).raises('error')
        post(translate_words_path, @params)
        response.status.should == 409
        response.should render_template('new')
      end
    end

    describe "save" do
      before(:each) do
        lang = Factory.create(:lang)
        @params = {
          :word => 'word1',
          :from => lang.value,
          :to => lang.value,
          :meanings => ['word2']
        }
      end

      it "should save words with meanings when valid data given" do
        post(save_words_path, @params)
        response.should be_successful
      end

      it "should render translate form when valid data given" do
        @params[:word] = nil
        post(save_words_path, @params)
        response.status.should == 409
      end
    end
  end

  context "not logged in user" do
    it "should show login form" do
      [words_path, new_word_path].each do |path|
        get(path)
        response.should redirect_to(new_session_path)
      end

      [translate_words_path, save_words_path].each do |path|
        post(path)
        response.should redirect_to(new_session_path)
      end
    end
  end
end
