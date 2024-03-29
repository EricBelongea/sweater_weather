require "rails_helper"

RSpec.describe '#Geolocation Facade' do
  it 'find_location', :vcr do
    response = GeolocationFacade.find_location("Salt Lake City, UT")

    expect(response).to be_a(String)
    expect(response).to eq("40.76031, -111.88822")
  end

  it "directions(origin, destination)", :vcr do
    response = GeolocationFacade.directions("Salt Lake City, UT", "Charlotte, NC")

    expect(response).to be_a(Hash)
    expect(response.count).to eq(2)
    expect(response).to have_key(:eta)
    expect(response[:eta]).to be_a(String)
    expect(response).to have_key(:hours)
    expect(response[:hours]).to be_a(Integer)
    expect(response[:hours]).to eq(29)
  end

  describe '#sad-path-geolocation' do
    it 'routes over oceans', :vcr do
      response = GeolocationFacade.directions("Salt Lake City, UT", "London, England")
      expect(response[:status]).to eq(402)
      expect(response[:error]).to eq("We are unable to route with the given locations.")
    end
  end
end