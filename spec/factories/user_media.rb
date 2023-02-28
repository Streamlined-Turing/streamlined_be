FactoryBot.define do
  factory :user_media do
    media_id { Faker::Number.number(digits: 6) }
    user_rating { Faker::Number.between(from: 1, to: 5) }
    user_review { Faker::Restaurant.review}
  end
end