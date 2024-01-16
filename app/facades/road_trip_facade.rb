class RoadTripFacade
  def self.road_trip(params)
    trip_time = GeolocationFacade.directions(params[:origin], params[:destination])
    if trip_time[:status] == 402
      trip_time
    else
      multi_day_response = WeatherFacade.find_multi_day(params[:destination])
      space_and_time = linear_timeline(trip_time)
      forecast = build_forecast(multi_day_response, space_and_time[:index])
      build_road_trip(trip_time, forecast[space_and_time[:hour]], params)
    end
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

  def self.build_forecast(multi_day_response, space_and_time)
    multi_day_response[:forecast][:forecastday][space_and_time][:hour].map do |hour|
      {
        time: hour[:time],
        temp: hour[:temp_f],
        condition: hour[:condition][:text]

      }
    end
  end

  def self.linear_timeline(trip_time)
    total_hours = (Time.now.hour + trip_time[:hours])
    {
      index: total_hours / 24,
      hour: total_hours % 24
    }
  end
end