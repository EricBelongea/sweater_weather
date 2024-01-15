class GeolocationService  
  def self.conn 
    Faraday.new(url: "https://www.mapquestapi.com/" ) do |faraday|
      faraday.headers['key'] = Rails.application.credentials.geocoding[:key]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_location(lat_lng)
    get_url("/geocoding/v1/address?location=#{lat_lng}")
  end

  def self.directions(origin, destination)
    get_url("directions/v2/route?from=#{origin}&to=#{destination}")
  end
end