class CreateUserMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :user_media do |t|
      t.integer :media_id
      t.integer :user_rating
      t.string :user_review

      t.timestamps
    end
  end
end
