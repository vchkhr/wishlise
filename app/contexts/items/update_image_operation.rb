# frozen_string_literal: true

module Items
  class UpdateImageOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::UpdateImage, params.merge(user_id: current_user.id))

      @item = find_item
      update_item
      update_wishlist

      Success(@item)
    end

    private

    def find_item
      Item.find(@attrs[:id])
    end

    def update_item
      @item.image.attach(@attrs[:image])
    end

    def update_wishlist
      @item.wishlist.update(updated_at: Time.zone.now)
    end
  end
end
