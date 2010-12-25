Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.org" }
  u.sequence(:password) { "ala123" }
  u.sequence(:password_confirmation) { 'ala123' }
end

Factory.define :word do |u|
  u.sequence(:value) { |n| "word#{n}" }
  u.association(:lang)
end

Factory.define :lang do |u|
  u.sequence(:value) { "en" }
end

Factory.define :translation do |u|
  u.association(:from) { Factory.create(:word) }
  u.association(:to) { Factory.create(:word) }
end

def create_default_langs
  Lang.default_values.each { |l| Factory.create(:lang, :value => l) }
end
