# frozen_string_literal: true

module Wishlists
  class ShowOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Show, params.merge(user_id: current_user&.id))

      wishlist = Wishlist.find(@attrs[:id])

      Success(wishlist)
    end
  end
end
