FactoryGirl.define do
  factory :price do
    store
    product

    regular_price { Faker::Commerce.price }
    price         { Faker::Commerce.price }
  end
end
