class WordsController < BaseController
  before_filter :ensure_authenticated

  def index
    @from = Lang.get(params[:from]) || Lang.default_from
    @to = Lang.get(params[:to]) || Lang.default_to
    @available_langs = Lang.available_langs

    @words = current_user.words_by_languages(@from, @to)

    render
  end

  def new
    @word = Word.new
    @available_langs = Lang.available_langs
  end

  def translate
    @from = Lang.get(params[:word][:lang])
    @to = Lang.get(params[:word][:to])
    word_value = params[:word][:value]
    @word = Word.first(:value => word_value, :lang => @from) || Word.new(:value => word_value, :lang => @from)

    if @results = @word.extract_meanings(@from, @to)
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
    if Word.save_with_meanings(current_user, params[:word], params[:from_id], params[:to_id], params[:meanings])
      render :text => 'Yeah, translation saved!'
    else
      render :text => 'Oops, error, please try again.', :layout => false, :status => :conflict
    end
  end
end
