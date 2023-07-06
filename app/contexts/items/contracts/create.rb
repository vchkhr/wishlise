# frozen_string_literal: true

module Items
  module Contracts
    class Create < ::ApplicationContract
      params do
        optional(:title).maybe(:string, max_size?: 255)
        optional(:url).maybe(format?: /\A\z|(?i)\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/)
        optional(:description).maybe(:string, max_size?: 255)
        optional(:price).maybe(:float, gt?: 0)
        required(:wishlist_id).filled(:string)
        required(:user_id).filled(:integer)
      end

      rule(:title) do
        if value.blank? && values[:url].blank?
          key.failure("At least Title or URL should be specified")
        end
      end

      rule(:wishlist_id) do
        if User.find(values[:user_id]).wishlists.find_by(id: value).nil?
          key.failure("Wishlist not found")
        end
      end
    end
  end
end
