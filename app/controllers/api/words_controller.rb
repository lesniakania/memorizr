class Api::WordsController < Api::BaseController
  before_filter :ensure_authenticated

  def index
    @from = Lang.get(params[:from_id]) || Lang.default_from
    @to = Lang.get(params[:to_id]) || Lang.default_to

    render :json => current_user.words_hash_by_languages(@from, @to)
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

  def update_positions
    params[:words].each do |w|
      user_word = current_user.user_words.first(:word_id => w[:id])
      user_word.update(:position => w[:position]) if user_word
    end

    head :ok
  end
end
