Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.org" }
  u.sequence(:password) { "ala123" }
end

