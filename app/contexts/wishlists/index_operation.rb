# frozen_string_literal: true

module Wishlists
  class IndexOperation < ::ApplicationOperation
    def call(params, current_user)
      @wishlists = current_user.wishlists.order(updated_at: :desc)

      Success(@wishlists)
    end
  end
end
