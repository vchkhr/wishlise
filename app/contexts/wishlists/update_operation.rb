# frozen_string_literal: true

module Wishlists
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Update, params.merge(user_id: current_user.id))

      @wishlist = find_wishlist
      @wishlist = update_wishlist

      Success(@wishlist)
    end

    private

    def find_wishlist
      Wishlist.find(@attrs[:id])
    end

    def update_wishlist
      @wishlist.update(@attrs)
    end
  end
end
