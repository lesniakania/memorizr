class SessionForm < WebForm
  attr_accessor :email, :password, :user_id

  validates_each :email do |record, attr, value|
    unless record.errors.key?(:email)
      user = User.first(:email => record.email)
      if user.nil? || user.password != record.password
        record.errors.add :session, "Invalid email/password combination."
      else
        record.user_id = user.id
      end
    end
  end

end
