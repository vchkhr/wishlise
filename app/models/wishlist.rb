class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_one_attached :image

  enum :publicity, %i(hidden by_link listed)
end
