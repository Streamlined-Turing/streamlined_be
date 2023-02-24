class RemoveMediaIdFromMediaLists < ActiveRecord::Migration[5.2]
  def change
    remove_column :media_lists, :media_id, :integer
  end
end
