FactoryGirl.define do
  factory :log do
    recurring

    descritpion { Faker::Lorem.sentence(3) }
  end
end
