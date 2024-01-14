FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Alphanumeric.alpha(number: 15) }
    api_key { Faker::Alphanumeric.alpha(number: 15) }
  end
end