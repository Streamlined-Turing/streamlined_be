class AddUserMediaToMediaLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :media_lists, :user_media, foreign_key: true
  end
end
