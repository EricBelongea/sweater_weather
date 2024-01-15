class Api::V0::RoadTripController < ApplicationController
  def create
    if  params[:api_key].blank? || !User.find_by(api_key: params[:api_key])
      render json: { status: 401, error: "Unauthorized"}, status: :unauthorized
    elsif params[:origin].blank? || params[:destination].blank?
      render json: { status: 400, error: "All fields are required" }, status: :bad_request
    else
      road_trip = RoadTripFacade.road_trip(road_trip_params)
      render json: road_trip
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end