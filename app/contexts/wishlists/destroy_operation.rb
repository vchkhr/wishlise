# frozen_string_literal: true

module Wishlists
  class DestroyOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Destroy, params.merge(user_id: current_user.id))

      @wishlist = find_wishlist
      @wishlist = destroy_wishlist

      Success(@wishlist)
    end

    private

    def find_wishlist
      Wishlist.find(@attrs[:id])
    end

    def destroy_wishlist
      @wishlist.destroy
    end
  end
end
