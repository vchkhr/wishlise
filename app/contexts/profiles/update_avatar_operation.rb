# frozen_string_literal: true

module Profiles
  class UpdateAvatarOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield validate(Contracts::UpdateAvatar, params.merge(user_id: @current_user.id))

      @profile = find_profile
      update_profile

      Success(@profile)
    end

    private

    def find_profile
      @current_user.profile
    end

    def update_profile
      @profile.avatar.attach(@attrs[:avatar])
    end
  end
end
