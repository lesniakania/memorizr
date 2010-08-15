Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.org" }
  u.sequence(:password) { "ala123" }
end

Factory.define :word do |u|
  u.sequence(:value) { |n| "word#{n}" }
  u.association(:lang)
  u.association(:user)
end

Factory.define :lang do |u|
  u.sequence(:value) { "en" }
end

def create_default_langs
  Lang.defaults.each { |l| Factory.create(:lang, :value => l) }
end
