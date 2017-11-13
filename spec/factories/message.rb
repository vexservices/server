FactoryGirl.define do
  factory :message do
    store
    device

    message Faker::Lorem.word
  end
end
