module CommonProperties
  def self.included(base)
    base.class_eval do
      property :id, DataMapper::Property::Serial
      property :created_at, DateTime, :index => true
      property :updated_at, DateTime
    end
  end
end