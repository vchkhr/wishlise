# frozen_string_literal: true

module Wishlists
  class ShowOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Show, params.merge(user_id: current_user&.id))

      @wishlist = find_wishlist

      Success(@wishlist)
    end

    private
    def find_wishlist
      Wishlist.find(@attrs[:id])
    end
  end
end
