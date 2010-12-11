class WordsController < ApplicationController
  before_filter :ensure_authenticated

  def index
    @from = Lang.first(:value => params[:from] || Lang.default_from)
    @to = Lang.first(:value => params[:to] || Lang.default_to)
    @available_langs = Lang.available_langs

    @words = current_user.words_by_languages(@from, @to)

    respond_to do |format|
      format.html { render }
      format.json { render :json => @words.map { |w| w.hash_format(@to) } }
    end
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

    if @results = @word.extract_meanings(@from, @to)
      respond_to do |format|
        format.html { render :partial => 'results' }
        format.json { render :json => @results.map(&:hash_format) }
      end
    else
      respond_to do |format|
        format.html do
          @available_langs = Lang.available_langs
          render :new, :layout => false, :status => :conflict
        end
        format.json { head :conflict }
      end
    end
  end

  def destroy
    word_id = params[:id]
    @user_word = UserWord.first(:word_id => word_id, :user_id => current_user.id)
    if @user_word.destroy
      respond_to do |format|
        format.html { render :text => word_id }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :text => "Oops, error while destroying.", :status => :conflict }
        format.json { head :conflict }
      end
    end
  end

  def save
    if Word.save_with_meanings(current_user, params[:word], params[:from], params[:to], params[:meanings])
      respond_to do |format|
        format.html { render :text => 'Yeah, translation saved!' }
        format.json  { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :text => 'Oops, error, please try again.', :layout => false, :status => :conflict }
        format.json { head :conflict }
      end
    end
  end
end
