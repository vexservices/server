FactoryGirl.define do
  factory :change do
    log     { Faker::Lorem.sentence(3) }
    checked false
  end
end
