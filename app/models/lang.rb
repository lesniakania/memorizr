class Lang
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256

  validates_presence_of :value

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
end