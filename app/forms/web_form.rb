class WebForm
  include ActiveModel::Validations
  extend ActiveModel::Naming

  def initialize(attrs={})
    attrs.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def id
    nil
  end

  def to_key
    nil
  end

end
