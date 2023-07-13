# frozen_string_literal: true

module Wishlists
  class IndexOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Index, params)

      wishlists = if @attrs[:username]
                    Profile.find_by(username: @attrs[:username]).user.wishlists.listed
                  else
                    current_user.wishlists
                  end

      wishlists = wishlists.order(updated_at: :desc)

      Success(wishlists)
    end
  end
end
