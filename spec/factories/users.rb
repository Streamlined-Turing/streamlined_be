FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    uid { Faker::Number.number(digits: 29) }
    image { Faker::Internet.url }
  end
end