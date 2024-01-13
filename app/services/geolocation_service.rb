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

  def self.find_location(params)
    get_url("/geocoding/v1/address?location=#{params}")
  end
end