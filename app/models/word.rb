class Word
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256
  property :user_id, Integer, :required => true
  property :word_id, Integer, :required => false
  property :lang_id, Integer, :required => true

  validates_presence_of :value, :lang_id, :user_id

  has n, :meanings, Word
  belongs_to :user
  belongs_to :lang

  def self.save_with_meanings(user, value, from, to, meanings)
    lang_from = Lang.first(:value => from)
    lang_to = Lang.first(:value => to)
    word = Word.new(:value => value, :lang => lang_from, :user => user)
    words = meanings.map { |m| Word.new(:value => m, :lang => lang_to, :user => user) }
    if word.valid? && words.all?(&:valid?)
      word.save
      words.each do |meaning|
        meaning.save
        word.meanings << meaning
      end
      word.save
    else
      false
    end
  end
end