require "rails_helper"

RSpec.describe '#Geolocation Facade' do
  it 'Will return a lat long string', :vcr do
    response = GeolocationFacade.find_location("Salt Lake City, UT")

    expect(response).to be_a(String)
    expect(response).to eq("40.76031, -111.88822")
  end
end