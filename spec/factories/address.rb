FactoryGirl.define do
  factory :address do
    street    { Faker::Address.street_address }
    city      { Faker::Address.city }
    state     { Faker::Address.state }
    zip       { Faker::Address.zip_code }
    country   { Faker::Address.country }
    longitude { Faker::Address.longitude }
    latitude  { Faker::Address.latitude }
  end
end
