class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :set_profile, only: %i[ show ]
  before_action :set_current_profile, only: %i[ edit complete_registration update ]

  def show
    redirect_to root_url, notice: "Profile not found." unless @profile
  end

  def edit
  end

  def complete_registration
    if current_user.profile.username
      redirect_to root_url, notice: "You have already completed the registration."
      return
    end

    render :edit
  end

  def update
    previous_username = current_user.profile.username
    result = Profiles::UpdateOperation.new.call(profile_params, current_user)

    if result.success?
      if previous_username.nil?
        redirect_to root_url, notice: "You have completed the registration."
      else
        redirect_to profile_by_username_path(current_user.profile.username), notice: "Profile was successfully updated."
      end
    else
      render turbo_stream: turbo_stream.replace(:profile_form_frame, partial: "profiles/form", locals: { profile: current_user.profile, values: profile_params, errors: result.failure[1].errors.to_h })
    end
  end

  def update_avatar
    result = current_user.profile.update(avatar: profile_params[:avatar])

    render turbo_stream: turbo_stream.replace(:profile_avatar_form_frame, partial: "profiles/avatar_form", locals: { profile: current_user.profile, result: result })
  end

  def destroy_avatar
    result = current_user.profile.update(avatar: nil)

    render turbo_stream: turbo_stream.replace(:profile_avatar_form_frame, partial: "profiles/avatar_form", locals: { profile: current_user.profile, result: "Profile image was removed." })
  end

  private
  def set_profile
    @profile = Profile.find_by(username: params[:username])
  end

  def set_current_profile
    @profile = current_user.profile
  end

  def profile_params
    params[:profile]
  end
end
