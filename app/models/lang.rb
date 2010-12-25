class Lang
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256

  validates_presence_of :value
  validates_uniqueness_of :value

  DEFAULTS = { :from => 'en', :to => 'pl' }

  def self.default_from
    Lang.first(:value => DEFAULTS[:from])
  end

  def self.default_to
    Lang.first(:value => DEFAULTS[:to])
  end

  def self.default_values
    DEFAULTS.values
  end

  def self.available_langs
    all(:order => [:value]).map { |l| [l.value, l.id] }
  end

  def hash_format
    { :id => id, :value => value }
  end

  def self.index_hash
    {
      :available => all(:order => [:value]).map(&:hash_format),
      :default_from => Lang.default_from.id,
      :default_to => Lang.default_to.id
    }
  end
end