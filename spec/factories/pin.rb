FactoryGirl.define do
  factory :pin do
    device
    publish
    product

    name          { Faker::Name.name }
    category_name { Faker::Commerce.department }
    description   { Faker::Lorem.sentence(3) }
    contact_info  { Faker::Lorem.sentence(3) }
    regular_price { Faker::Commerce.price }
    price         { Faker::Commerce.price }
    store_name    { Faker::Name.name }
  end
end
