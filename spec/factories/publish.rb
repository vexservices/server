FactoryGirl.define do
  factory :publish do
    store
    product

    price         { Faker::Commerce.price }
    regular_price { Faker::Commerce.price }

    published_by_corporate false

    trait :corporate do
      published_by_corporate true
    end

    trait :removed do
      removed_at Faker::Time.between(2.days.ago, 1.days.ago)
    end

    trait :published do
      published_until DateTime.now + 1.day
    end
  end
end
