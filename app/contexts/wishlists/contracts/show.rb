# frozen_string_literal: true

module Wishlists
  module Contracts
    class Show < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:id) do
        unless User.find(values[:user_id]).wishlists.find_by(id: value) || !Wishlist.find_by(id: value).hidden?
          key.failure("Wishlist not found.")
        end
      end
    end
  end
end
