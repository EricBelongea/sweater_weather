class RoadTripFacade
  def self.road_trip(params)
    trip_time = GeolocationFacade.directions(params[:origin], params[:destination])
    require 'pry'; binding.pry
  end
end