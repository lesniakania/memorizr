class Word
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256, :message => 'forgot to type a word?'
  property :lang_id, Integer, :required => true

  has n, :translations, :child_key => [:from_id]
  has n, :meanings, self, :through => :translations, :via => :to

  validates_uniqueness_of :value, :scope => :lang_id

  belongs_to :lang

  def self.save_with_meanings(user, value, from_id, to_id, meanings)
    lang_from = Lang.get(from_id)
    lang_to = Lang.get(to_id)
    word = Word.first(:value => value, :lang => lang_from) || Word.new(:value => value, :lang => lang_from)
    words = Word.build_meanings(meanings, lang_to)
    
    if word.valid? && words.all?(&:valid?)
      word.save
      words = Word.build_meanings(meanings, lang_to)
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

  def self.build_meanings(meanings, to)
    meanings.map { |m| Word.first(:value => m, :lang => to) || Word.new(:value => m, :lang => to) }
  end

  def extract_meanings(from, to)
    if valid?
      meanings = meanings_to(to) || []
      if meanings.empty?
        meanings = Translator.extract_meanings(self, from, to)
        if meanings
          meanings = Word.build_meanings(meanings, to)
        else
          errors.add(:value, 'Oops, error, please try again.')
        end
      end
      meanings
    else
      false
    end
  end

  def meanings_to(lang)
    meanings.all(:lang => lang)
  end

  def hash_format(include_meanings_to = nil)
    hash = { :id => id, :value => value, :lang_id => lang_id }
    if include_meanings_to
      hash.merge!({ :meanings => meanings_to(include_meanings_to).map(&:hash_format) })
    end
    hash
  end
end