class Translation
  include DataMapper::Resource
 
  property :from_id, Integer, :key => true
  property :to_id, Integer, :key => true

  belongs_to :from, Word
  belongs_to :to, Word

  validates_presence_of :from_id, :to_id
end
