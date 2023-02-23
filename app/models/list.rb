class List < ApplicationRecord
  belongs_to :user
  has_many :media_lists
  has_many :user_medias, through: :media_lists
end
