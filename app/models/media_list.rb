class MediaList < ApplicationRecord
  belongs_to :list
  belongs_to :user_media, :foreign_key => 'media_id', :class_name => 'UserMedia', :primary_key => 'media_id'
end
