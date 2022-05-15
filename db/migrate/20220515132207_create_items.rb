class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.belongs_to :list, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :url
      t.string :image_url
      t.integer :price

      t.timestamps
    end
  end
end
