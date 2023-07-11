# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :username
      t.string :display_name

      t.timestamps
    end
  end
end
