# frozen_string_literal: true

module Wishlists
  module Contracts
    class Destroy < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:id) do
        if Wishlist.find_by(id: value).nil? || Wishlist.find_by(id: value).user_id != values[:user_id]
          key.failure("Wishlist not found")
        end
      end
    end
  end
end