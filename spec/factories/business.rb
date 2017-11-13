FactoryGirl.define do
  factory :business do
    name { Faker::Commerce.department }

    after(:create) do |b|
      FactoryGirl.create_list(:image, 3, business: b)
    end
  end
end
