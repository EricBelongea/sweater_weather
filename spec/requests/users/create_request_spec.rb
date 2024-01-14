require "rails_helper"

RSpec.describe "Users Create Request" do
  it "Will Create a user", :vcr do
    user_request = {
      email: "ur_an@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post api_v0_users_path, params: user_request
    new_user = User.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(new_user).to be_instance_of User
    expect(new_user.email).to eq(user_request[:email])
    expect(new_user.api_key).to be_a(String)
    expect(new_user.id).to be_a(Integer)
  end

  describe '#sad-path' do
    it 'matching passwords', :vcr do
      user_request = {
      email: "mismatch@example.com",
      password: "password",
      password_confirmation: "nope"
      }

      post api_v0_users_path, params: user_request
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Password confirmation doesn't match Password")
    end

    it "email has already been taken", :vcr do
      user_request = {
      email: "mismatch@example.com",
      password: "password",
      password_confirmation: "password"
      }

      post api_v0_users_path, params: user_request

      user2 = {
        email: "mismatch@example.com",
        password: "password",
        password_confirmation: "password"
        }
      post api_v0_users_path, params: user2
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Email has already been taken")
    end

    it "Missing email", :vcr do
      user_request = {
        email: "",
        password: "password",
        password_confirmation: "password"
      }

      post api_v0_users_path, params: user_request
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Email can't be blank, Email is invalid")
    end

    it "not an email", :vcr do
      user_request = {
        email: "notanemail",
        password: "password",
        password_confirmation: "password"
      }

      post api_v0_users_path, params: user_request
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Email is invalid")
    end

    it "missing password", :vcr do
      user3 = {
        email: "missing@example.com",
        password: "",
        password_confirmation: "password"
        }

      post api_v0_users_path, params: user3
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Password digest can't be blank, Password can't be blank")
    end

    it "missing password_confirmation", :vcr do
      user3 = {
        email: "missing@example.com",
        password: "password",
        password_confirmation: ""
        }

      post api_v0_users_path, params: user3
      response_body = JSON.parse(response.body,symbolize_names: true)

      expect(response).to_not be_successful 
      expect(response.status).to eq(400)
      expect(response_body[:error]).to eq("Password confirmation doesn't match Password")
    end
  end
end