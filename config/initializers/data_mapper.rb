config_data = YAML.load(File.read(Rails.root / 'config' / 'database.yml'))
adapter = config_data[Rails.env]['adapter']
username = config_data[Rails.env]['username']
password = config_data[Rails.env]['password']
host = config_data[Rails.env]['host']
database_name = config_data[Rails.env]['database']

DataMapper.setup(:default, ENV['DATABASE_URL'] || "#{adapter}://#{username}:#{password}@#{host}/#{database_name}")

