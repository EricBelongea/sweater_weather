class WeatherFacade
  def self.find_forecast(params)
    lat_lng = GeolocationFacade.find_location(params)

    
  end
end