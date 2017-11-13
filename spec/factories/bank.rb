FactoryGirl.define do
  factory :bank do
    seller

    name    { Faker::Company.name }
    number  { Faker::Number.number(8) }
    agency  { Faker::Number.number(4) }
  end
end
