class UserMedia < ApplicationRecord
  has_one :media_list
  has_one :list, through: :media_list
  has_one :user, through: :list
end
