# frozen_string_literal: true

module Wishlists
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:id).filled(:integer)
        required(:user_id).filled(:integer)
        required(:title).filled(:string)
        required(:publicity).filled(Dry::Types["string"].enum(*Wishlist.publicities.collect{ |name, _num| name }))
      end

      rule(:id) do
        unless User.find(values[:user_id]).wishlists.find_by(id: value)
          key.failure("Wishlist not found.")
        end
      end
    end
  end
end
