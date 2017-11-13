FactoryGirl.define do
  factory :street do
    device

    address   { Faker::Address.street_address }
    longitude { Faker::Address.longitude }
    latitude  { Faker::Address.latitude }
  end
end
