# frozen_string_literal: true

module Items
  class UpdateImageOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::UpdateImage, params.merge(user_id: current_user.id))

      item = Item.find(@attrs[:id])
      item.image.attach(@attrs[:image])
      item.wishlist.update(updated_at: Time.zone.now)

      Success(item)
    end
  end
end
