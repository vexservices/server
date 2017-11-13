FactoryGirl.define do
  factory :department do
    store
    name  { Faker::Commerce.department }
    title { Faker::Commerce.department }

    trait :sub do
      department
    end

    trait :super do
      store nil
    end
  end
end
