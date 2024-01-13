class WeatherService
  def self.conn
    Faraday.new( url: "http://api.weatherapi.com/") do |faraday|
      faraday.headers['key'] = Rails.application.credentials.weather[:key]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_forecast(params)
    get_url("/v1/forecast.json?q=#{params}")
  end
end