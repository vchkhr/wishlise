# frozen_string_literal: true

class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  enum :publicity, %i[hidden by_link listed]

  broadcasts_to ->(wishlist) { [ wishlist.user, :wishlists ] }, inserts_by: :prepend
end
