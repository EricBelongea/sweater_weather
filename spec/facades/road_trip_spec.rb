require "rails_helper"

RSpec.describe "Road Trip Facade" do
  it "return a json object", :vcr do
    params = {
      origin: "Salt Lake City, UT",
      destination: "Bishop, CA",
    }
    response = RoadTripFacade.road_trip(params)

    expect(response).to be_a Hash
    expect(response[:data]).to be_a Hash
    expect(response[:data][:id]).to eq(nil)
    expect(response[:data][:type]).to eq("road_trip")
    expect(response[:data][:attributes]).to be_a Hash

    expect(response[:data][:attributes].count).to eq(4)
    expect(response[:data][:attributes][:start_city]).to eq(params[:origin])
    expect(response[:data][:attributes][:start_city]).to be_a String
    expect(response[:data][:attributes][:end_city]).to eq(params[:destination])
    expect(response[:data][:attributes][:end_city]).to be_a String
    expect(response[:data][:attributes][:travel_time]).to be_a String
    expect(response[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(response[:data][:attributes][:weather_at_eta].count).to eq(3)
    
    expect(response[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
    expect(response[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
    expect(response[:data][:attributes][:weather_at_eta][:condition]).to be_a String
  end

  describe '#sad-path-roadtrip' do
    it 'routes over oceans', :vcr do
      params = {
        origin: "Salt Lake City, UT",
        destination: "London, England",
      }
      response = RoadTripFacade.road_trip(params)

      expect(response[:status]).to eq(402)
      expect(response[:error]).to eq("We are unable to route with the given locations.")
    end
  end
end