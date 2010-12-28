require 'spec_helper'

describe Api::WordsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, Api::WordsController)
    end
    
    describe "index" do
      before(:each) do
        @word = Factory.create(:word, :lang => Lang.default_from)
        @meaning = Factory.create(:word, :lang => Lang.default_to)
        @word.meanings << @meaning
        @word.save

        @user.words << @word
        @user.save
      end

      it "should show only current users words" do
        get(api_words_path)
        response.should be_successful
        word = JSON.parse(response.body).first
        Set.new(word.keys).should == Set.new(['id', 'value', 'lang_id', 'created_at', 'meanings'])
        word['id'].should == @word.id
        word['value'].should == @word.value
        word['lang_id'].should == @word.lang_id
        word['created_at'].should == @user.user_words.first(:word => @word).created_at.to_s
        meaning = word['meanings'].first
        Set.new(meaning.keys).should == Set.new(['id', 'value', 'lang_id'])
        meaning['id'].should == @meaning.id
        meaning['value'].should == @meaning.value
        meaning['lang_id'].should == @meaning.lang_id
      end

      it "should be able to filter words" do
        get(api_words_path, { :from => @en.id, :to => @pl.id })
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
        @meaning = Factory.create(:word, :lang => @pl)
        @meanings = [@meaning]
        Word.any_instance.stubs(:extract_meanings).returns(@meanings)

        post(translate_api_words_path, @params)
        response.should be_successful

        results = JSON.parse(response.body)
        meaning = results.first
        Set.new(meaning.keys).should == Set.new(['id', 'value', 'lang_id'])
        meaning['id'].should == @meaning.id
        meaning['value'].should == @meaning.value
        meaning['lang_id'].should == @meaning.lang_id
      end

      it "should render translate form if any error appears during translation" do
        Net::HTTP.stubs(:get_response).raises('error')
        post(translate_api_words_path, @params)
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
        post(save_api_words_path, @params)
        response.should be_successful
        word = JSON.parse(response.body)
        word['id'].should_not be_nil
      end

      it "should render translate form when invalid data given" do
        @params[:word] = nil
        post(save_api_words_path, @params)
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
        delete(api_word_path(@word))
        response.should be_successful
        @user.reload.words.first(:value => @word.value).should be_nil
        Word.first(:value => @word.value, :lang => @word.lang).should_not be_nil
      end

      it "should handle error properly" do
        UserWord.any_instance.stubs(:destroy).returns(false)
        delete(api_word_path(@word))
        response.status.should == 409
      end
    end
  end

  context "not logged in user" do
    it "should show login form" do
      get(api_words_path)
      response.status.should == 401

      [translate_api_words_path, save_api_words_path].each do |path|
        post(path)
        response.status.should == 401
      end
    end
  end
end
