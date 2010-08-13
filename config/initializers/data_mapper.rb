config_data = YAML.load(File.read(Rails.root / 'config' / 'database.yml'))
adapter = config_data[Rails.env]['adapter']
database_name = config_data[Rails.env]['database']

DataMapper.setup(:default, "#{adapter}:#{database_name}")
