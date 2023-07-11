# frozen_string_literal: true

module Wishlists
  class CreateOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield validate(Contracts::Create, params)

      @wishlist = create_wishlist

      Success(@wishlist)
    end

    private

    def create_wishlist
      @current_user.wishlists.create(@attrs)
    end
  end
end
