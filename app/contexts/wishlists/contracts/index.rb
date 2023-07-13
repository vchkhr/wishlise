# frozen_string_literal: true

module Wishlists
  module Contracts
    class Index < ::ApplicationContract
      params do
        optional(:username).maybe(:string)
      end

      rule(:username) do
        key.failure('not found') if value && Profile.find_by(username: value).nil?
      end
    end
  end
end
