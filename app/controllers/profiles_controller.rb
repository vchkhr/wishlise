class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ edit update ]

  def edit
  end

  def update
    previous_username = current_user.profile.username
    result = Profiles::UpdateOperation.new.call(profile_params, current_user)

    if result.success?
      if previous_username.empty?
        redirect_to root_url, notice: "You have completed your account registration."
      else
        # TODO: notice: "Profile was successfully updated."
      end
    else
      profile = ErrorWrapper.new(result, profile_params, model: @profile)
      render turbo_stream: turbo_stream.replace(:profile_form_frame, partial: "profiles/form", locals: { profile: profile })
    end
  end

  def update_avatar
    result = current_user.profile.update(profile_avatar_params)

    render turbo_stream: turbo_stream.replace(:profile_avatar_form_frame, partial: "profiles/avatar_form", locals: { profile: current_user.profile, result: result })
  end

  def destroy_avatar
    result = current_user.profile.update(avatar: nil)

    render turbo_stream: turbo_stream.replace(:profile_avatar_form_frame, partial: "profiles/avatar_form", locals: { profile: current_user.profile, result: "Profile photo was removed." })
  end

  private
  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:username, :display_name)
  end

  def profile_avatar_params
    params.require(:profile).permit(:avatar)
  end
end
