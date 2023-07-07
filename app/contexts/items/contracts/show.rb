# frozen_string_literal: true

module Items
  module Contracts
    class Show < ::ApplicationContract
      params do
        required(:id).filled(:string)
        optional(:user_id).maybe(:integer)
      end

      rule(:id) do
        if Item.find_by(id: value).nil? || (Item.find_by(id: value).wishlist.hidden? && (values[:user_id].nil? || User.find(values[:user_id]) != Item.find_by(id: value).wishlist.user))
          key.failure("Item not found")
        end
      end
    end
  end
end
