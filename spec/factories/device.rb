FactoryGirl.define do
  factory :device do
    store
    push_token { Faker::Number.number(18) }
    kind 1

    trait :android do
      kind 2
    end

    trait :apple_token do
      push_token '1111111122222222333333334444444455555555666666667777777788888888'
    end
  end
end
