# frozen_string_literal: true

module Profiles
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Update, params.merge(user_id: current_user.id))

      fill_display_name
      update_profile

      Success(@profile)
    end

    private
    def fill_display_name
      @attrs[:display_name] = @attrs[:username] unless @attrs[:display_name]
    end

    def update_profile
      @profile = current_user.profile.update(@attrs)
    end
  end
end
