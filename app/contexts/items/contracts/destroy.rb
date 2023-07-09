# frozen_string_literal: true

module Items
  module Contracts
    class Destroy < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:id) do
        if Item.find_by(id: value).nil? || Item.find_by(id: value).wishlist.user_id != values[:user_id]
          key.failure("Item not found")
        end
      end
    end
  end
end
