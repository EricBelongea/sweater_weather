class GeolocationFacade
  def self.find_location(params)
    response =  GeolocationService.find_location(params)
    build_lat_long(response)
  end

  def self.directions(origin, destination)
    response = GeolocationService.directions(origin, destination)
    if response[:info][:statuscode] == 402
      {
        # 402 == parment required, change HTTP status
        status: 402,
        error: response[:info][:messages].first
      }
    else
      raw_time = response[:route][:realTime]
      eta = format_time(raw_time)
      time = { eta: (format_time(raw_time)), hours:( raw_time / 3600) }
      return time
    end
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