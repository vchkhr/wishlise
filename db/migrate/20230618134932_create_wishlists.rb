# frozen_string_literal: true

class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :wishlists, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.integer :publicity, default: 0

      t.timestamps
    end
  end
end
