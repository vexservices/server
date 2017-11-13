FactoryGirl.define do
  factory :order do
    store

    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    address         { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state }
    zip             { Faker::Address.zip }
    card_expires_on { Faker::Business.credit_card_expiry_date }
    card_brand      { Faker::Business.credit_card_type }
    log             { Faker::Lorem.sentence(3) }
  end
end
