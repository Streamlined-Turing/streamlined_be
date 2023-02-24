FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    sub { Faker::Number.number(digits: 29) }
    picture { Faker::Internet.url }
  end
end
