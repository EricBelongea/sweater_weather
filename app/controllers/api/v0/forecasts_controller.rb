class Api::V0::ForecastsController < ApplicationController
  def index

  end

  def search
    forecast = 
    location = GeolocationFacade.find_location(params[:location])
    return location
    # require 'pry'; binding.pry
  end
end