class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :gallery_name
      t.string :gallery_image
      t.belongs_to :child, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
