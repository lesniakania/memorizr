class UserWord
  include DataMapper::Resource
  include CommonProperties

  belongs_to :user, User, :key => true
  belongs_to :word, Word, :key => true
end
