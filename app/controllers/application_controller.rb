# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def complete_registration!
    return unless current_user

    unless current_user.profile
      profile = Profile.create(user: current_user)
      profile.save(validate: false)
    end

    redirect_to complete_registration_path unless current_user.profile.username
  end
end
