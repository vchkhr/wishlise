# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :complete_registration!, only: %i[welcome]

  def welcome
    redirect_to wishlists_path if current_user
  end
end
