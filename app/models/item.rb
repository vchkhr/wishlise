# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :wishlist
  has_one_attached :image

  scope :with_image, lambda {
    joins(:image_blob).where(active_storage_blobs: { content_type: ActiveStorage.variable_content_types })
  }

  broadcasts_to ->(item) { :items }, inserts_by: :prepend
end
