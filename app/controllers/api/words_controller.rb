class Api::WordsController < Api::BaseController
  before_filter :ensure_authenticated

  def index
    @from = Lang.get(params[:from]) || Lang.default_from
    @to = Lang.get(params[:to]) || Lang.default_to
    @available_langs = Lang.available_langs

    @words = current_user.words_by_languages(@from, @to)

    render :json => @words.map { |w| w.hash_format(@to) }
  end

  def translate
    @from = Lang.get(params[:word][:lang])
    @to = Lang.get(params[:word][:to])
    word_value = params[:word][:value]
    @word = Word.first(:value => word_value, :lang => @from) || Word.new(:value => word_value, :lang => @from)

    if @results = @word.extract_meanings(@from, @to)
      render :json => @results.map(&:hash_format)
    else
      head :conflict
    end
  end

  def destroy
    @user_word = UserWord.first(:word_id => params[:id], :user_id => current_user.id)
    if @user_word.destroy
      head :ok
    else
      head :conflict
    end
  end

  def save
    if word = Word.save_with_meanings(current_user, params[:word], params[:from_id], params[:to_id], params[:meanings])
      render :json => word.hash_format
    else
      head :conflict
    end
  end
end
