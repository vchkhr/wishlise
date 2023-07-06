class CreateItems < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :items, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.belongs_to :wishlist, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.string :url
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
