require "rails_helper"

RSpec.describe "User Serializer" do
  it "Can create parse into JSON" do
    user1 = User.create(email: "example#gemail.com", password_digest: "123abc", api_key: "123456789")

    expect(user1).to be_instance_of(User)
  end
end