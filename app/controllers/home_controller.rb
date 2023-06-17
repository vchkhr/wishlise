class HomeController < ApplicationController
  def new
    redirect_to wishlists_path if current_user
  end

  def webmanifest
  end

  def browserconfig
  end
end
