# frozen_string_literal: true

module Profiles
  class UpdateAvatarOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::UpdateAvatar, params)

      profile = current_user.profile
      profile.avatar.attach(@attrs[:avatar])

      Success(profile)
    end
  end
end
