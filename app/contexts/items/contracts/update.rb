# frozen_string_literal: true

module Items
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
        required(:wishlist_id).filled(:string)
        optional(:title).maybe(:string, max_size?: 255)
        optional(:url).maybe(format?: %r{\A\z|(?i)\A(http|https)://[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?/.*)?\z})
        optional(:description).maybe(:string, max_size?: 255)
        optional(:price).maybe(:float, gt?: 0)
      end

      rule(:id) do
        key.failure('Item not found') if Item.find_by(id: value).nil? || User.find_by(id: values[:user_id]).nil? || Item.find_by(id: value).wishlist.user_id != values[:user_id]
      end

      rule(:title) do
        key.failure('At least Title or URL should be specified') if value.blank? && values[:url].blank?
      end
    end
  end
end
