class UserMedia < ApplicationRecord
  has_one :media_list, dependent: :destroy
  has_one :list, through: :media_list
  has_one :user, through: :list

  validates :user_rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
end
