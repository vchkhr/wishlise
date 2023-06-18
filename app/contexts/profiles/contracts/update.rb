# frozen_string_literal: true

module Profiles
  module Contracts
    class Update < ::ApplicationContract
      params do
        required(:user_id).filled(:integer)
        required(:username).filled(:string)
        optional(:display_name).maybe(:string)
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
