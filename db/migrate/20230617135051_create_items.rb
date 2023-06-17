class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.belongs_to :wishlist, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
