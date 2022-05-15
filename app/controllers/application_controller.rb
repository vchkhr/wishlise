class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def require_profile!
    if current_user.profile.nil?
      redirect_to new_profile_url
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "We can't let you in here ;("
    redirect_back(fallback_location: root_path)
  end
end
