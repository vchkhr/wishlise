class HomeController < ApplicationController
  before_action :complete_registration!, only: %i[ welcome ]
end
