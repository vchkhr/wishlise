# frozen_string_literal: true

module Items
  module Contracts
    class ParseExternalData < ::ApplicationContract
      params do
        required(:id).filled(:string)
      end

      rule(:id) do
        key.failure('not found') if Item.find_by(id: value).nil?
      end
    end
  end
end
