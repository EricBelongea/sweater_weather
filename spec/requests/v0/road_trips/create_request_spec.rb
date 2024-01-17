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

  describe '#sad-path road-trip' do
    it 'no origin', :vcr do
      road_trip = {
        origin: "",
        destination: "Chicago,IL",
        api_key: @new_user.api_key
      }

      post api_v0_road_trip_index_path, params: road_trip
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("All fields are required")
    end

    it 'no destination', :vcr do
      road_trip = {
        origin: "SLC, UT",
        destination: "",
        api_key: @new_user.api_key
      }

      post api_v0_road_trip_index_path, params: road_trip
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("All fields are required")
    end

    it 'no key', :vcr do
      road_trip = {
        origin: "SLC, UT",
        destination: "Chicago,IL",
        api_key: ""
      }

      post api_v0_road_trip_index_path, params: road_trip
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response_body[:error]).to eq("Unauthorized")
    end

    it 'bad key', :vcr do
      road_trip = {
        origin: "SLC, UT",
        destination: "Chicago,IL",
        api_key: "FooBar"
      }

      post api_v0_road_trip_index_path, params: road_trip
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response_body[:error]).to eq("Unauthorized")
    end

    it "trip over ocean", :vcr do
      road_trip = {
        origin: "SLC, UT",
        destination: "Moscow, Russia",
        api_key: @new_user.api_key
      }

      post api_v0_road_trip_index_path, params: road_trip
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response_body[:status]).to eq(402)
      expect(response_body[:error]).to eq("We are unable to route with the given locations.")
    end
  end
end