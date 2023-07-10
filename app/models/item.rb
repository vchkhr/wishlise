class Item < ApplicationRecord
  belongs_to :wishlist
  has_one_attached :image

  scope :with_image, -> do
    joins(:image_blob).where(active_storage_blobs: {content_type: ActiveStorage.variable_content_types})
  end
end
