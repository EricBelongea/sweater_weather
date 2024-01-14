require "rails_helper"

RSpec.describe "User Serializer" do
  it "Can create parse into JSON" do
    FactoryBot.create!(:user)
    require 'pry'; binding.pry
  end
end