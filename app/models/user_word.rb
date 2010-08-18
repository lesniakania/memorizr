class UserWord
  include DataMapper::Resource

  belongs_to :user, Word, :key => true
  belongs_to :word, Word, :key => true
end
