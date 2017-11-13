FactoryGirl.define do
  factory :recurring do
    store
    profile_id { Faker::Number.number(10) }
    value      { Faker::Commerce.price }

    trait :canceled do
      canceled_a DateTime.now
    end
  end
end
