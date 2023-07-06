# frozen_string_literal: true

module Items
  class CreateOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield Validate(Contracts::Create, params.merge(user_id: current_user.id))

      @item = create_item
      update_wishlist

      Success(@item)
    end

    private
    def create_item
      Item.create(@attrs.except(:user_id))
    end

    def update_wishlist
      @item.wishlist.update(updated_at: Time.zone.now)
    end
  end
end
