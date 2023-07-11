# frozen_string_literal: true

module Wishlists
  module Contracts
    class Destroy < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:id) do
        key.failure('not found') if Wishlist.find_by(id: value).nil? || Wishlist.find_by(id: value).user_id != values[:user_id]
      end
    end
  end
end
