class MediaList < ApplicationRecord
  belongs_to :list
  belongs_to :user_media
  has_one :user, through: :list
end
