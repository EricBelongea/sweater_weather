class YelpFacade
  def self.find_food(params)
    require 'pry'; binding.pry
    weather = WeatherFacade.find_forecast(params[:destination])
    response = YelpService.find_food(params)
    require 'pry'; binding.pry
  end
end