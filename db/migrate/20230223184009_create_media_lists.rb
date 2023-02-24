class CreateMediaLists < ActiveRecord::Migration[5.2]
  def change
    create_table :media_lists do |t|
      t.integer :media_id
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
