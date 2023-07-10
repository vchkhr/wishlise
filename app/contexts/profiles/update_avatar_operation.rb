# frozen_string_literal: true

module Profiles
  class UpdateAvatarOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield Validate(Contracts::UpdateAvatar, params.merge(user_id: @current_user.id))

      @profile = update_profile

      Success(@profile)
    end

    private
    def update_profile
      @current_user.profile.avatar.attach(@attrs[:avatar])
    end
  end
end
