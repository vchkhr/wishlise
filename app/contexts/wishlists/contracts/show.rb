# frozen_string_literal: true

module Wishlists
  module Contracts
    class Show < ::ApplicationContract
      params do
        required(:id).filled(:string)
        optional(:user_id).maybe(:integer)
      end

      rule(:id) do
        key.failure('not found') if Wishlist.find_by(id: value).nil? || (Wishlist.find_by(id: value).hidden? && (values[:user_id].nil? || Wishlist.find_by(id: value).user_id != values[:user_id]))
      end
    end
  end
end
