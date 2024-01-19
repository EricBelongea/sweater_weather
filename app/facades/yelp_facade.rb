class YelpFacade
  def self.find_food(params)
    weather = WeatherFacade.find_forecast(params[:destination])
    yelp = YelpService.find_food(params)
    destination = build_destination(params[:destination])
    munchie = create_munchie(weather, yelp, destination)
    return munchie
  end

  private

  def self.create_munchie(weather, yelp, destination)
    {
      data: {
        id: nil,
        type: "munchie",
        attributes: {
          destination_city: destination,
          forecast: build_weather_munchie(weather),
          restaurant: build_yelp_munchie(yelp)
        }
      }
    }
  end

  def self.build_weather_munchie(weather)
    {
      summary: weather[:data][:attributes][:current_weather][:condition],
      temperature: weather[:data][:attributes][:current_weather][:temperature]
    }
  end

  def self.build_yelp_munchie(yelp)
    {
      name: yelp[:businesses].first[:name],
      address: yelp[:businesses].first[:location][:display_address].join(', '),
      rating: yelp[:businesses].first[:rating],
      reviews: yelp[:businesses].first[:review_count]
    }
  end

  def self.build_destination(destination)
    city, state = destination.split(',').map(&:strip)
    dest = "#{city.capitalize}, #{state.upcase}"
  end
end