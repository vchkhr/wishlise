# frozen_string_literal: true

module Wishlists
  module Contracts
    class Create < ::ApplicationContract
      params do
        required(:title).filled(:string)
        required(:publicity).filled(Dry::Types["string"].enum(*Wishlist.publicities.collect{ |name, num| name }))
      end
    end
  end
end
