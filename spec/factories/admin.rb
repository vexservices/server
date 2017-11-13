FactoryGirl.define do
  factory :admin do
    name  { Faker::Name.name }
    email { Faker::Internet.email }

    password '12345678'
    password_confirmation '12345678'
    encrypted_password '$2a$10$Fi4xREBlYLmyVPZZj367VOCDGvNkiJRwrs3.ZpFJ916EOb7qZCS/e'

    trait :with_franchise do
      franchise
    end
  end
end
