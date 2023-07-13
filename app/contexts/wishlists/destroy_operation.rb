# frozen_string_literal: true

module Wishlists
  class DestroyOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Destroy, params.merge(user_id: current_user.id))

      wishlist = Wishlist.find(@attrs[:id])
      wishlist.destroy

      Success(wishlist)
    end
  end
end
