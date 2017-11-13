FactoryGirl.define do
  factory :image do
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/app.png')))

    trait :with_store do
      store
    end

    trait :with_business do
      business
    end
  end
end
