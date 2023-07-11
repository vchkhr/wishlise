# frozen_string_literal: true

module Profiles
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:user_id).filled(:integer)
        required(:username).filled(:string, min_size?: 6, max_size?: 255)
        optional(:display_name).maybe(:string, min_size?: 2, max_size?: 255)
      end

      rule(:username) do
        key.failure('must be unique') if Profile.where(username: value).where.not(user_id: values[:user_id]).present?
      end
    end
  end
end
