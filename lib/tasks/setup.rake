namespace :memorizr do
  desc "Setup application"
  task :setup => :environment do
    User.create(:email => 'lesniakania@gmail.com', :password => 'qwerty')
    ['en', 'pl'].each { |value| Lang.create(:value => value) }
  end

  desc "Clear whole database"
  task :clear_database => :environment do
    DataMapper::Model.descendants.each {|m| m.all.destroy }
  end
end
