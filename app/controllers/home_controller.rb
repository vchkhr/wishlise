class HomeController < ApplicationController
  def index
    if current_user
      require_profile!

      if current_user.profile
        require_list
      end
    end
  end

  private
  def require_list
    if current_user.lists.empty?
      redirect_to new_list_url
    end
  end
end
