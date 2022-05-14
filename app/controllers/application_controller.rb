class ApplicationController < ActionController::Base
  def require_profile!
    if current_user.profile.nil?
      redirect_to new_profile_url
    end
  end
end
