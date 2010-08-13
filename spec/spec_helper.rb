ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{Rails.root}/spec/support/**/*.rb"].each {|f| require f}

DataMapper.auto_migrate!

Rspec.configure do |config|
  config.mock_with :mocha

  # Remove this line if you don't want Rspec's should and should_not
  # methods or matchers
  require 'rspec/expectations'

  config.before(:each) do
    DataMapper::Model.descendants.each {|m| m.all.destroy }
  end
end
