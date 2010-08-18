class WordsController < ApplicationController
  before_filter :ensure_authenticated

  def index
    from = params[:from] || Lang.default_from
    to = params[:to] || Lang.default_to
    @from = Lang.first(:value => from)
    @to = Lang.first(:value => to)
    @available_langs = Lang.all.map { |l| [l.value, l.value] }

    @words = Word.extract_words(@from, @to, current_user)
  end

  def new
    @word = Word.new
    @available_langs = Lang.all.map { |l| [l.value, l.value] }
  end

  def translate
    @word = params[:word][:value]
    @from = params[:word][:lang]
    @to = params[:word][:to]

    if @results = Word.extract_meanings(@word, @from, @to)
      render :partial => 'results'
    else
      @word = Word.new
      @available_langs = Lang.all.map { |l| [l.value, l.value] }
      render :new, :status => :conflict
    end
  end

  def save
    if Word.save_with_meanings(current_user, params[:word], params[:from], params[:to], params[:meanings])
      render :text => 'Translation successfully saved.'
    else
      @word = Word.new
      @available_langs = Lang.all.map { |l| [l.value, l.value] }
      render :new, :status => 409
    end
  end
end
