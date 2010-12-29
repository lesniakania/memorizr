class UserWord
  include DataMapper::Resource
  include CommonProperties

  belongs_to :user, User, :key => true
  belongs_to :word, Word, :key => true

  property :lang_id, Integer, :required => true
  belongs_to :lang

  before :valid? do
    self.lang_id = word.lang_id
  end

  is :list, :scope => [:user_id, :lang_id]
end
