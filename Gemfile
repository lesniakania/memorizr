$heroku = ENV['USER'] ? !! ENV['USER'].match(/^repo\d+/) : ENV.any?{|key, _| key.match(/^HEROKU_/)}

source 'http://rubygems.org'

gem 'rails'
gem 'bcrypt-ruby', '2.1.2', :require => 'bcrypt'

gem 'nokogiri'

gem 'dm-postgres-adapter'
gem 'dm-rails'
gem 'dm-core'
gem 'dm-validations'
gem 'dm-migrations'
gem 'dm-timestamps'

gem 'vidibus-routing_error'
gem 'heroku'

unless $heroku
  group :development, :test do
    gem 'ruby_core_source', :require => 'ruby_core_source'
    gem 'ruby-debug19', :require => 'ruby-debug'
    gem "rspec", '2.0.0.beta.18'
    gem "rspec-rails", '2.0.0.beta.18'
    gem 'mocha'
    gem "factory_girl_rails", "1.0"
  end
end
