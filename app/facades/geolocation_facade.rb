class GeolocationFacade
  def self.find_location(params)
    response =  GeolocationService.find_location(params)
    lat_long_object = build_lat_long(response)
    return lat_long_object
  end

  def self.directions(origin, destination)
    response = GeolocationService.directions(origin, destination)
    raw_time = response[:route][:realTime]
    eta = format_time(raw_time)
    time = { eta: (format_time(raw_time)), hours:( raw_time / 3600) }
    return time
  end

  private

  def self.build_lat_long(response)
    latlng = response[:results].first[:locations].first[:latLng]
    object =  "#{latlng[:lat]}, #{ latlng[:lng]}"
  end

  def self.format_time(time)
    hours = time / 3600
    minutes = time % 3600 / 60
    return "#{hours} hours #{minutes} minutes"
  end
end