class HomeController < ApplicationController
  def index
    if current_user
      require_profile!

      if current_user.profile
        if current_user.lists.empty?
          redirect_to new_list_url
        else
          redirect_to lists_url
        end
      end
    end
  end
end
