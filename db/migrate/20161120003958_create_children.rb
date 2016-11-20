class CreateChildren < ActiveRecord::Migration[5.0]
  def change
    create_table :children do |t|
      t.string :child_name
      t.string :image
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
