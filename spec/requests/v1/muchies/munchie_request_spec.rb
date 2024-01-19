require "rails_helper"

RSpec.describe "Muchie Request" do
  it "Will return has we want", :vcr do
    denver = "denver, co"
    italian = 'italian'

    get "http://localhost:3000/api/v1/munchies?destination=#{denver}&food=#{italian}"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(response_body).to be_a(Hash)
    expect(response_body[:data][:id]).to eq(nil)
    expect(response_body[:data]).to have_key(:type)
    expect(response_body[:data][:type]).to eq("munchie")
    expect(response_body[:data][:type]).to be_a(String)
    expect(response_body[:data][:attributes]).to be_a(Hash)
    expect(response_body[:data][:attributes][:destination_city]).to eq("Denver, CO")
    expect(response_body[:data][:attributes][:destination_city]).to be_a(String)
    expect(response_body[:data][:attributes].count).to eq(3)
    expect(response_body[:data][:attributes][:forecast].count).to eq(2)
    expect(response_body[:data][:attributes][:forecast][:summary]).to be_a(String)
    expect(response_body[:data][:attributes][:forecast][:temperature]).to be_a(Float)
    expect(response_body[:data][:attributes][:restaurant].count).to eq(4)
    expect(response_body[:data][:attributes][:restaurant][:name]).to be_a(String)
    expect(response_body[:data][:attributes][:restaurant][:address]).to be_a(String)
    expect(response_body[:data][:attributes][:restaurant][:rating]).to be_a(Float)
    expect(response_body[:data][:attributes][:restaurant][:reviews]).to be_a(Integer)
  end

  describe '#sadpath' do
    it 'misssing city', :vcr do
      denver = ""
      italian = 'italian'

      get "http://localhost:3000/api/v1/munchies?destination=#{denver}&food=#{italian}"
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response_body[:status]).to eq(400)
      expect(response_body[:error]).to eq("Must have a Desition or Food category")
    end

    it 'misssing food param', :vcr do
      denver = "denver, co"
      italian = ''

      get "http://localhost:3000/api/v1/munchies?destination=#{denver}&food=#{italian}"
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response_body[:status]).to eq(400)
      expect(response_body[:error]).to eq("Must have a Desition or Food category")
    end
  end
end