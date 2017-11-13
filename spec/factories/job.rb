FactoryGirl.define do
  factory :job do
    store

    name   'Job'
    log    { Faker::Lorem.sentence(3) }
    closed false

    import_type 0
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/product_sample.csv')))

    trait :branch_store do
      import_type 1
      file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/store_sample.csv')))
    end

    trait :department do
      import_type 2
      file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/department_sample.csv')))
    end
  end
end
