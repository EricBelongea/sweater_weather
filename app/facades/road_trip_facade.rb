class RoadTripFacade
  def self.road_trip(params)
    trip_time = GeolocationFacade.directions(params[:origin], params[:destination])
    multi_day_response = WeatherFacade.find_multi_day(params[:destination])
    forecast = build_forecast(multi_day_response, trip_time)
    build_road_trip(trip_time, forecast[(Time.now.hour + trip_time[:hours]) - 24], params)
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
            datetime: forecast[:time],
            temperature: forecast[:temp],
            condition: forecast[:condition]
          }
        }
      }
    }
  end

  def self.build_forecast(multi_day_response, trip_time)
    multi_day_response[:forecast][:forecastday][(Time.now.hour + trip_time[:hours]) / 24][:hour].map do |hour|
      {
        time: hour[:time],
        temp: hour[:temp_f],
        condition: hour[:condition][:text]

      }
    end
  end
end