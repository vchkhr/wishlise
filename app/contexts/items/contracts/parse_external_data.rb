# frozen_string_literal: true

module Items
  module Contracts
    class ParseExternalData < ::ApplicationContract
      params do
        required(:id).filled(:string)
      end

      rule(:id) do
        if Item.find_by(id: value).nil?
          key.failure("Item not found")
        end
      end
    end
  end
end
