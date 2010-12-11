class Lang
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256

  validates_presence_of :value
  validates_uniqueness_of :value

  DEFAULTS = { :from => 'en', :to => 'pl' }

  def self.default_from
    DEFAULTS[:from]
  end

  def self.default_to
    DEFAULTS[:to]
  end

  def self.defaults
    DEFAULTS.values
  end

  def self.available_langs
    all(:order => [:value]).map { |l| [l.value, l.value] }
  end

  def hash_format
    { :id => id, :value => value }
  end

  def self.index_hash
    {
      :available => all(:order => [:value]).map(&:hash_format),
      :default_from => Lang.default_from,
      :default_to => Lang.default_to
    }
  end
end