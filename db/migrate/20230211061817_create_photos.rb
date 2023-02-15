class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.string :title, limit: 30, null: false

      t.timestamps
    end
  end
end
