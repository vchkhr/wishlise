# frozen_string_literal: true

module Profiles
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield validate(Contracts::Update, params.merge(user_id: @current_user.id))

      fill_display_name
      @profile = find_profile
      update_profile

      Success(@profile)
    end

    private

    def fill_display_name
      @attrs[:display_name] = @attrs[:username] unless @attrs[:display_name]
    end

    def find_profile
      @current_user.profile
    end

    def update_profile
      @profile.update(@attrs)
    end
  end
end
