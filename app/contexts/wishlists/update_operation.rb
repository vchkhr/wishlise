# frozen_string_literal: true

module Wishlists
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Update, params.merge(user_id: current_user.id))

      wishlist = Wishlist.find(@attrs[:id])
      wishlist.update(@attrs)

      Success(wishlist)
    end
  end
end
