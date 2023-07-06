# frozen_string_literal: true

module Wishlists
  module Contracts
    class Show < ::ApplicationContract
      params do
        required(:id).filled(:string)
        optional(:user_id).maybe(:integer)
      end

      rule(:id) do
        if Wishlist.find_by(id: value).nil? || (Wishlist.find_by(id: value).hidden? && (values[:user_id].nil? || User.find(values[:user_id]).wishlists.find_by(id: value).nil?))
          key.failure("Wishlist not found")
        end
      end
    end
  end
end
