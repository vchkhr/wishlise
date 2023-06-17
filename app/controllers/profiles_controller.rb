class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[ edit update ]

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:user_id, :username, :display_name, :avatar)
  end
end
