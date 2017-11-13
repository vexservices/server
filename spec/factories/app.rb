FactoryGirl.define do
  sequence :app_name do |n|
    "App Name #{n}"
  end

  factory :app do
    name            { generate(:app_name) }
    apple_store_url { Faker::Internet.url }
    google_play_url { Faker::Internet.url }
    google_api_key  { Faker::Number.number(30) }
    use_logo true

    trait :with_store do
      store
    end

    trait :logo do
      app_cover Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/app.png')))
    end

    trait :pendent do
      use_logo false
    end
  end
end
