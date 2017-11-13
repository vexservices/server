FactoryGirl.define do
  factory :seller do
    address

    name       { Faker::Name.name }
    email      { Faker::Internet.free_email }
    cell_phone { Faker::PhoneNumber.cell_phone }
    phone      { Faker::PhoneNumber.phone_number }
    password   '12345678'
    password_confirmation '12345678'
    encrypted_password    '$2a$10$Fi4xREBlYLmyVPZZj367VOCDGvNkiJRwrs3.ZpFJ916EOb7qZCS/e'
    commission 35.0

    trait :sub do
      seller
      commission 20.0
    end
  end
end
