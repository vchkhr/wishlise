# frozen_string_literal: true

module Items
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:id).filled(:string)
        required(:user_id).filled(:integer)
        optional(:title).maybe(:string, max_size?: 255)
        optional(:url).maybe(format?: /\A\z|(?i)\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/)
        optional(:description).maybe(:string, max_size?: 255)
        optional(:price).maybe(:float, gt?: 0)
        required(:wishlist_id).filled(:string)
      end

      rule(:id) do
        if Item.find_by(id: value).nil? || User.find_by(id: values[:user_id]).nil? || Item.find_by(id: value).wishlist.user_id != values[:user_id]
          key.failure("Item not found")
        end
      end

      rule(:title) do
        if value.blank? && values[:url].blank?
          key.failure("At least Title or URL should be specified")
        end
      end
    end
  end
end
