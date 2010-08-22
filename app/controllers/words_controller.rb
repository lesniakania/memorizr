class WordsController < ApplicationController
  before_filter :ensure_authenticated

  def index
    @from = Lang.first(:value => params[:from] || Lang.default_from)
    @to = Lang.first(:value => params[:to] || Lang.default_to)
    @available_langs = Lang.available_langs

    @words = Word.extract_words(@from, @to, current_user)
  end

  def new
    @word = Word.new
    @available_langs = Lang.available_langs
  end

  def translate
    @from = Lang.first(:value => params[:word][:lang])
    @to = Lang.first(:value => params[:word][:to])
    word_value = params[:word][:value]
    @word = Word.first(:value => word_value, :lang => @from) || Word.new(:value => word_value, :lang => @from)

    if @results = Word.extract_meanings(@word, @from, @to)
      render :partial => 'results'
    else
      @available_langs = Lang.available_langs
      render :new, :layout => false, :status => :conflict
    end
  end

  def destroy
    word_id = params[:id]
    @user_word = UserWord.first(:word_id => word_id, :user_id => current_user.id)
    if @user_word.destroy
      render :text => word_id
    else
      render :text => "Oops, error while destroying.", :status => :conflict
    end
  end

  def save
    if Word.save_with_meanings(current_user, params[:word], params[:from], params[:to], params[:meanings])
      render :text => 'Yeah, translation saved!'
    else
      render :text => 'Oops, error, please try again.', :layout => false, :status => 409
    end
  end
end
