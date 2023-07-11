# frozen_string_literal: true

module Items
  module Contracts
    class Destroy < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:id) do
        key.failure('Item not found') if Item.find_by(id: value).nil? || Item.find_by(id: value).wishlist.user_id != values[:user_id]
      end
    end
  end
end
