# frozen_string_literal: true

module Profiles
  module Contracts
    class UpdateAvatar < ::ApplicationContract
      params do
        required(:user_id).filled(:integer)
        required(:avatar)
      end
    end
  end
end
