require "rails_helper"

RSpec.describe "Road Trip Controller" do
  before :each do
    user_request = {
      email: "ur_an@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post api_v0_users_path, params: user_request
    @new_user = User.last
  end
  it "Can create a Road Trip", :vcr do
    road_trip = {
      origin: "Cincinatti,OH",
      destination: "Chicago,IL",
      api_key: @new_user.api_key
    }

    post api_v0_road_trip_index_path, params: road_trip

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)

    # require 'pry'; binding.pry
    expect(response_body).to be_a Hash
    expect(response_body[:data]).to be_a Hash
    expect(response_body[:data][:id]).to eq(nil)
    expect(response_body[:data][:type]).to eq("road_trip")
    expect(response_body[:data][:attributes]).to be_a Hash
    expect(response_body[:data][:attributes][:start_city]).to eq(road_trip[:origin])
    expect(response_body[:data][:attributes][:start_city]).to be_a String
    expect(response_body[:data][:attributes][:end_city]).to eq(road_trip[:destination])
    expect(response_body[:data][:attributes][:end_city]).to be_a String
    expect(response_body[:data][:attributes][:travel_time]).to be_a String
    expect(response_body[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(response_body[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
    expect(response_body[:data][:attributes][:weather_at_eta][:condition]).to be_a String
    expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
  end
end