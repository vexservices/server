FactoryGirl.define do
  factory :client do
    store

    name     { Faker::Name.name }
    username { Faker::Internet.email }
    blocked  false
    password '12345678'
  end
end
