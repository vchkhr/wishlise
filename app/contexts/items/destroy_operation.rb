# frozen_string_literal: true

module Items
  class DestroyOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Destroy, params.merge(user_id: current_user.id))

      item = Item.find(@attrs[:id])
      item.wishlist.update(updated_at: Time.zone.now)
      item.destroy

      Success(item)
    end
  end
end
