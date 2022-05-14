class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.integer :emoji_cd
      t.integer :visibility_cd

      t.timestamps
    end
  end
end
