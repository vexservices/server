FactoryGirl.define do
  factory :category do
    name { Faker::Commerce.department }

    trait :sub do
      category
    end
  end
end
