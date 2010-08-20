class Word
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256, :message => 'forgot to type a word?'
  property :lang_id, Integer, :required => true

  has n, :translations, :child_key => [:from_id]
  has n, :meanings, self, :through => :translations, :via => :to

  validates_uniqueness_of :value, :scope => :lang_id

  belongs_to :lang

  def self.save_with_meanings(user, value, from, to, meanings)
    lang_from = Lang.first(:value => from)
    lang_to = Lang.first(:value => to)
    word = Word.first(:value => value, :lang => lang_from) || Word.new(:value => value, :lang => lang_from)
    words = meanings.map { |m| Word.first(:value => m, :lang => lang_to) || Word.new(:value => m, :lang => lang_to) }

    if word.valid? && words.all?(&:valid?)
      word.save
      words = meanings.map { |m| Word.first(:value => m, :lang => lang_to) || Word.new(:value => m, :lang => lang_to) }
      user.words << word
      words.each do |meaning|
        meaning.save
        word.meanings << meaning
        user.words << meaning
      end
      user.save
      word.save
    else
      false
    end
  end

  def meanings_to(lang)
    meanings.all(:lang => lang)
  end

  def self.extract_words(from, to, user)
    words = user && user.words(:lang => from, :order => [:value])
    words.select { |w| w.meanings.any? { |m| m.lang == to } }
  end

  def self.extract_meanings(word, from, to)
    if word.valid?
      meanings = word.meanings.select { |m| m.lang == to }.map(&:value) || []
      if meanings.empty?
        meanings = Translator.extract_meanings(word, from, to)
        word.errors.add(:value, 'Oops, error, please try again.') unless meanings
      end
      meanings
    else
      false
    end
  end
end