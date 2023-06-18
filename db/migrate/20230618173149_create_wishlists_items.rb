class CreateWishlistsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists_items do |t|
      t.belongs_to :wishlist, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
