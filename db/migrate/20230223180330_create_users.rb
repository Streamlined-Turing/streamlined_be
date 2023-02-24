class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.string :uid
      t.string :username
      t.string :image

      t.timestamps
    end
  end
end
