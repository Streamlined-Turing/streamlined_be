class User < ApplicationRecord
  has_many :lists
  has_many :media_lists, through: :lists
  has_many :user_medias, through: :media_lists
end
