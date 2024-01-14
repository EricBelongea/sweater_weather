class YelpService
  def self.conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/" ) do |faraday|
      faraday.headers['API_KEY'] = Rails.application.credentials.yelp[:key]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_food(params)
    get_url("/search?location=#{params[:destination]}&categories=#{params[:food]}")
  end
end