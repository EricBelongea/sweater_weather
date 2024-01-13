class GeolocationFacade
  def self.find_location(params)
    require 'pry'; binding.pry
    response =  GeolocationService.find_location(params)
    require 'pry'; binding.pry
  end
end