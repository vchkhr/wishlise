class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :visibility_cd
      t.date :dob
      t.string :description
      t.string :messenger_url

      t.timestamps
    end
  end
end
