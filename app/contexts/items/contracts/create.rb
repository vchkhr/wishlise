# frozen_string_literal: true

module Items
  module Contracts
    class Create < ::ApplicationContract
      params do
        optional(:title).maybe(:string, max_size?: 255)
        optional(:url).maybe(format?: %r{\A\z|(?i)\A(http|https)://[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?/.*)?\z})
        optional(:description).maybe(:string, max_size?: 255)
        optional(:price).maybe(:float, gt?: 0)
        required(:wishlist_id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:url) do
        key.failure('At least URL or title should be specified') if value.blank? && values[:title].blank?
      end

      rule(:wishlist_id) do
        key.failure('Wishlist not found') if Wishlist.find_by(id: value).nil? || Wishlist.find_by(id: value).user_id != values[:user_id]
      end
    end
  end
end
