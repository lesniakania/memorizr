require 'spec_helper'

describe WordsController do
  context "logged in user" do
    before(:each) do
      @user = Factory.create(:user)
      login(@user, WordsController)
    end

    describe "index" do
      ['html', 'json'].each do |format|
        it "should show only current users words" do
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

          get(words_path, :format => format)
          response.should be_successful
          response.body.should include(@word.value)
          response.body.should_not include(word.value)
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

          params = { :from => 'en', :to => 'pl' }

          get(words_path, params.merge(:format => format))
          response.should be_successful
          en_word1.reload
          [en_word1, pl_word].each { |w| response.body.should include(w.value) }
          [en_word2, hr_word].each { |w| response.body.should_not include(w.value) }
        end
      end
    end


    describe "new" do
      it "should render translate form properly" do
        get(new_word_path)
        response.should be_successful
      end
    end

    describe "translate" do
      ['html', 'json'].each do |format|
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
          @meanings = (1..2).map { |m| Factory.create(:word, :lang => @pl) }
          Word.any_instance.stubs(:extract_meanings).returns(@meanings)
          post(translate_words_path, @params.merge(:format => format))
          response.should be_successful
          @meanings.each { |m| response.body.should include(m.value.to_s) }
        end

        it "should render translate form if any error appears during translation" do
          Net::HTTP.stubs(:get_response).raises('error')
          post(translate_words_path, @params.merge(:format => format))
          response.status.should == 409
        end
      end
    end

    describe "save" do
      ['html', 'json'].each do |format|
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
          post(save_words_path, @params.merge(:format => format))
          response.should be_successful
        end

        it "should render translate form when invalid data given" do
          @params[:word] = nil
          post(save_words_path, @params.merge(:format => format))
          response.status.should == 409
        end
      end
    end

    describe "destroy" do
      ['html', 'json'].each do |format|
        before(:each) do
          @word = Factory.create(:word)
          @user.words << @word
          @user.save
        end

        it "should destroy user word successfully" do
          delete(word_path(@word), :format => format)
          response.should be_successful
          @user.reload.words.first(:value => @word.value).should be_nil
          Word.first(:value => @word.value, :lang => @word.lang).should_not be_nil
        end

        it "should handle error properly" do
          UserWord.any_instance.stubs(:destroy).returns(false)
          delete(word_path(@word), :format => format)
          response.status.should == 409
        end
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
