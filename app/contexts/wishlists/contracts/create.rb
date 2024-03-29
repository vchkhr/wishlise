# frozen_string_literal: true

module Wishlists
  module Contracts
    class Create < ::ApplicationContract
      params do
        required(:title).filled(:string, max_size?: 255)
        required(:publicity).filled(Dry::Types['string'].enum(*Wishlist.publicities.collect { |name, _num| name }))
      end
    end
  end
end
