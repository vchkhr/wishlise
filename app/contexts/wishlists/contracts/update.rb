# frozen_string_literal: true

module Wishlists
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
        required(:title).filled(:string, max_size?: 255)
        required(:publicity).filled(Dry::Types['string'].enum(*Wishlist.publicities.collect { |name, _num| name }))
      end

      rule(:id) do
        key.failure('Wishlist not found') if Wishlist.find_by(id: value).nil? || Wishlist.find_by(id: value).user_id != values[:user_id]
      end
    end
  end
end
