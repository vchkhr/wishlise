class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :delete_all
  has_one_attached :image

  enum :publicity, %i(hidden by_link listed)
end
