class Api::V0::ForecastsController < ApplicationController
  def index

  end

  def search
    require 'pry'; binding.pry
    location = GeolocationFacade.find_location(params[:location])
  end
end