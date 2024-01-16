class RoadTripFacade
  def self.road_trip(params)
    trip_time = GeolocationFacade.directions(params[:origin], params[:destination])
    forecast = WeatherFacade.find_forecast(params[:destination])
    build_road_trip(trip_time, forecast, params)
  end

  private 

  def self.build_road_trip(trip_time, forecast, params)
    {
      data: {
        id: nil,
        type: "road_trip",
        attributes: {
          start_city: params[:origin],
          end_city: params[:destination],
          travel_time: trip_time[:eta],
          weather_at_eta: {
            datetime: forecast[:data][:attributes][:hourly_weather][trip_time[:hours]-1][:time],
            temperature:  forecast[:data][:attributes][:hourly_weather][trip_time[:hours]-1][:temperature],
            condition:  forecast[:data][:attributes][:hourly_weather][trip_time[:hours]-1][:conditions]
          }
        }
      }
    }
  end
end