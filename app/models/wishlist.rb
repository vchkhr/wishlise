class Wishlist < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  enum :publicity, %i(hidden by_link listed)
end
