class MediaList < ApplicationRecord
  belongs_to :list
  belongs_to :user_media
  #Might need to add optional: true next to :user_media in the future
  #so that media_list can be created without a user_media_id. 
  has_one :user, through: :list

  after_destroy :destroy_user_media

  private 

  def destroy_user_media 
    user_media.destroy
  end
end
