# frozen_string_literal: true

module Items
  module Contracts
    class UpdateImage < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
        required(:image)
      end

      rule(:id) do
        key.failure('not found') if Item.find_by(id: value).nil? || User.find_by(id: values[:user_id]).nil? || Item.find_by(id: value).wishlist.user_id != values[:user_id]
      end
    end
  end
end
