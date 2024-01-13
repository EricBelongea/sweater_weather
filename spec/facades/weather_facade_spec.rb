require "rails_helper"

RSpec.describe "Weather Facade" do
  it 'returns only what we want.', :vcr do
    response = WeatherFacade.find_forecast("Salt Lake City, UT")

    response_data = response[:data]
    
    expect(response_data[:id]).to eq(nil)
    expect(response_data[:type]).to be_a(String)
    expect(response_data[:type]).to eq("forecast")
    expect(response_data[:attributes]).to be_a(Hash)
    
    
    current_weather = response[:data][:attributes][:current_weather]

    expect(current_weather).to be_a(Hash)
    expect(current_weather.count).to eq(8)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather[:icon]).to be_a(String)

    daily_weather = response[:data][:attributes][:daily_weather]

    expect(daily_weather).to be_a(Hash)
    expect(daily_weather[:date]).to be_a(String)
    expect(daily_weather[:sunrise]).to be_a(String)
    expect(daily_weather[:sunset]).to be_a(String)
    expect(daily_weather[:max_temp]).to be_a(Float)
    expect(daily_weather[:min_temp]).to be_a(Float)
    expect(daily_weather[:condition]).to be_a(String)
    expect(daily_weather[:icon]).to be_a(String)

    hourly_weather = response[:data][:attributes][:hourly_weather]

    expect(hourly_weather).to be_a(Array)
    expect(hourly_weather.count).to eq(24)

    hourly_weather.each do |hour|
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
    end
  end
end