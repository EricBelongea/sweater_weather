class WeatherFacade
  def self.find_forecast(params)
    lat_lng = GeolocationFacade.find_location(params)
    response = WeatherService.find_forecast(lat_lng)
    build_forecast_response(response)
  end
  
  def self.find_multi_day(params)
    WeatherService.find_multi_day(params)
  end

  private

  def self.build_forecast_response(response)
    {
      data: {
        id: nil,
        type: "forecast",
        attributes: {
          current_weather: {
            last_updated: response[:current][:last_updated],
            temperature: response[:current][:temp_f],
            feels_like: response[:current][:feelslike_f],
            humidity: response[:current][:humidity],
            uvi: response[:current][:uv],
            visibility: response[:current][:vis_miles],
            condition: response[:current][:condition][:text],
            icon: response[:current][:condition][:icon]
          },
          daily_weather: {
            date: response[:forecast][:forecastday].first[:date],
            sunrise: response[:forecast][:forecastday].first[:astro][:sunrise],
            sunset: response[:forecast][:forecastday].first[:astro][:sunset],
            max_temp: response[:forecast][:forecastday].first[:day][:maxtemp_f],
            min_temp: response[:forecast][:forecastday].first[:day][:mintemp_f],
            condition: response[:forecast][:forecastday].first[:day][:condition][:text],
            icon: response[:forecast][:forecastday].first[:day][:condition][:icon]
          },
          hourly_weather: build_hourly(response)
        }
      }
    }
  end

  def self.build_hourly(response)
    response[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end