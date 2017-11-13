FactoryGirl.define do
  factory :product do
    store
    category

    name           { Faker::Commerce.product_name }
    description    { Faker::Lorem.sentence(3) }
    contact_info   { Faker::Lorem.sentence(3) }
    regular_price  { Faker::Commerce.price }
    price          { Faker::Commerce.price }
    show_all       false
    code           { Faker::Number.number(4) }
    payment_option { Faker::Lorem.word }
  end
end
