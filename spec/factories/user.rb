FactoryGirl.define do
  factory :user do
    store

    name       { Faker::Name.name }
    email      { Faker::Internet.email }
    blocked    false
    password   '12345678'
    password_confirmation '12345678'
    encrypted_password    '$2a$10$Fi4xREBlYLmyVPZZj367VOCDGvNkiJRwrs3.ZpFJ916EOb7qZCS/e'
  end
end
