# frozen_string_literal: true

module Profiles
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:user_id).filled(:integer)
        required(:username).filled(:string, min_size?: 6, max_size?: 255)
        optional(:display_name).maybe(:string, min_size?: 2, max_size?: 255)
        optional(:avatar).maybe(:string)
      end

      rule(:username) do
        unless Profile.where(username: value).where.not(user_id: values[:user_id]).empty?
          key.failure("Username must be unique")
        end
      end
    end
  end
end
