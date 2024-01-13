class GeolocationFacade
  def self.find_location(params)
    response =  GeolocationService.find_location(params)

    lat_long_object = build_lat_long(response)
    return lat_long_object
    # require 'pry'; binding.pry
  end

  private

  def self.build_lat_long(response)
    latlng = response[:results].first[:locations].first[:latLng]
    object =  "#{latlng[:lat]}, #{ latlng[:lng]}"
  end
end