class Lang
  include DataMapper::Resource
  include CommonProperties

  property :value, String, :required => true, :length => 256

  validates_presence_of :value

  def self.default_from
    'en'
  end

  def self.default_to
    'pl'
  end
end