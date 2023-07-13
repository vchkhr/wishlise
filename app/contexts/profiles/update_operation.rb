# frozen_string_literal: true

module Profiles
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Update, params.merge(user_id: current_user.id))

      @attrs[:display_name] = @attrs[:username] unless @attrs[:display_name]
      profile = current_user.profile
      profile.update(@attrs)

      Success(profile)
    end
  end
end
