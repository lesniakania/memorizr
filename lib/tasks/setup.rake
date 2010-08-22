namespace :memorizr do
  desc "Setup application"
  task :setup => :environment do
    ['en', 'pl'].each { |value| Lang.create(:value => value) }
  end

  desc "Clear whole database"
  task :clear_database => :environment do
    DataMapper::Model.descendants.each {|m| m.all.destroy }
  end

  desc "Create user"
  task :create_user, [:email, :password] => :environment do |t, args|
    user = User.create(:email => args.email, :password => args.password, :password_confirmation => args.password)
    if user.valid?
      puts "User with email '#{args.email}' and password '#{args.password}' has been successfully created."
    else
      p user.errors.to_a
    end
  end

  desc "Delete user"
  task :delete_user, [:email] => :environment do |t, args|
    user = User.first(:email => args.email)
    if user.destroy
      puts "User with email '#{args.email}' has been successfully deleted."
    else
      p user.errors.to_a
    end
  end

  desc "Create language"
  task :create_lang, [:value] => :environment do |t, args|
    lang = Lang.create(:value => args.value)
    if lang.valid?
      puts "Lang with value '#{args.value}' has been successfully created."
    else
      p lang.errors.to_a
    end
  end
end
