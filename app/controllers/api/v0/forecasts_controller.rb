class Api::V0::ForecastsController < ApplicationController
  def index

  end

  def search
    forecast = WeatherFacade.find_forecast(params[:location])
    require 'pry'; binding.pry
  end
end