FactoryGirl.define do
  factory :invoice do
    store

    plan_name 'Plan'
    value     { Faker::Commerce.price }

    trait :paid do
      paid_at DateTime.now
    end
  end
end
