class WordsController < ApplicationController
  before_filter :ensure_authenticated

  def index
    lang_val = params[:lang] || Lang.default_from
    lang = Lang.first(:value => lang_val)
    @words = current_user.words(:lang => lang)
  end

  def new
    @word = Word.new
    @available_langs = Lang.all.map { |l| [l.value, l.value] }
  end

  def translate
    @word = params[:word][:value]
    @from = params[:word][:lang]
    @to = params[:word][:to]
    @results = Translator.retrieve_meanings(@word, @from, @to)
    render :partial => 'results'
  rescue
    @word = Word.new
    @available_langs = Lang.all.map { |l| [l.value, l.value] }
    render :new, :status => :conflict
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
