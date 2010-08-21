class User
  include DataMapper::Resource
  include CommonProperties
  include BCrypt
  
  property :email, String, :required => true, :length => 256
  property :password, String, :length => 256
  property :encrypted_password, String, :required => true, :length => 256

  attr_accessor :clear_text_password
  attr_accessor :password_confirmation

  validates_presence_of :email, :password
  validates_confirmation_of :clear_text_password, :confirm => :password_confirmation, :message => "Confirmation doesn't match"

  has n, :words, :through => :user_words

  validates_format_of :email, :with => Regexp::EMAIL
  validates_length_of :password, :min => 3, :max => 256

  def reload
    @password = nil
    @clear_text_password = nil
    super
  end

  def clear_password
    @password = nil
    self.encrypted_password = nil
  end

  def password
    @password ||= encrypted_password && Password.new(encrypted_password)
  end

  def password=(new_password)
    @clear_text_password = new_password
    if new_password.present?
      @password = Password.create(new_password)
      self.encrypted_password = @password
    else
      clear_password
    end
  end
end