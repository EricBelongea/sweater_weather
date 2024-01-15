class Api::V0::RoadTripController < ApplicationController
  def create
    if road_trip_params
      road_trip = RoadTripFacade.road_trip(road_trip_params)
      require 'pry'; binding.pry
    else
      render json: { status: 400, error: "All fields are required" }, status: :bad_request
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end