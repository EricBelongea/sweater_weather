require "rails_helper"

RSpec.describe "Login Request" do
  before :each do 
    user_params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post api_v0_users_path, params: user_params
  end
  it "Can login a user successfully", :vcr do
    user_params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post api_v0_sessions_path, params: user_params
    rb = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(rb[:data]).to have_key(:id)
    expect(rb[:data]).to have_key(:type)
    expect(rb[:data][:type]).to eq("user")
    expect(rb[:data][:attributes]).to have_key(:api_key)
    expect(rb[:data][:attributes]).to have_key(:email)
    expect(rb[:data][:attributes]).to_not have_key(:password)
    expect(rb[:data][:attributes]).to_not have_key(:password_digest)
  end

  describe '#sad-path login' do
    it 'missing email', :vcr do
      user_params = {
        "email": "",
        "password": "password"
      }

      post api_v0_sessions_path, params: user_params
      rb = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(rb[:error]).to eq("Sorry, Bad Credentials")
    end

    it 'Not an email', :vcr do
      user_params = {
        "email": "whatever@example",
        "password": "password"
      }

      post api_v0_sessions_path, params: user_params
      rb = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(rb[:error]).to eq("Sorry, Bad Credentials")
    end

    it 'missing password', :vcr do
      user_params = {
        "email": "whatever@example.com",
        "password": ""
      }

      post api_v0_sessions_path, params: user_params
      rb = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(rb[:error]).to eq("Sorry, Bad Credentials")
    end

    it 'mismatched password', :vcr do
      user_params = {
        "email": "whatever@example.com",
        "password": "nope"
      }

      post api_v0_sessions_path, params: user_params
      rb = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(rb[:error]).to eq("Sorry, Bad Credentials")
    end
  end
end