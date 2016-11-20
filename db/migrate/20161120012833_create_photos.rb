class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :photo_name
      t.string :photo_description
      t.belongs_to :gallery, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
