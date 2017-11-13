FactoryGirl.define do
  factory :store do
    address
    plan
    app

    name       { Faker::Company.name }
    phone      { Faker::PhoneNumber.cell_phone }
    cell_phone { Faker::PhoneNumber.cell_phone }
    time_zone  'UTC'
    token      'W9PKQEPjp98cjsoNxdPofQ'
    number     { Faker::Number.number(5) }
    corporate  true
    currency   'USD'
    trial_at   DateTime.now + 30.days
    payment_option 1

    about             { Faker::Lorem.sentence(9) }
    short_description { Faker::Lorem.sentence(3) }

    trait :ready do
      app_logo { FactoryGirl.create(:image) }
      image
    end

    trait :payment_fo_all do
      payment_option 2
    end

    trait :with_app_image do
      app_logo { FactoryGirl.create(:image) }
    end

    trait :branch_store do
      corporate false
      app nil
    end

    trait :with_franchise do
      franchise
    end
  end
end
