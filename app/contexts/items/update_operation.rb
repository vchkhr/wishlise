# frozen_string_literal: true

module Items
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Update, params.merge(user_id: current_user.id))

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
      @item.update(@attrs.except(:user_id))
    end

    def update_wishlist
      @item.wishlist.update(updated_at: Time.zone.now)
    end
  end
end
