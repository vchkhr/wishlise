# frozen_string_literal: true

module Wishlists
  class CreateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Create, params)

      wishlist = current_user.wishlists.create(@attrs)

      Success(wishlist)
    end
  end
end
