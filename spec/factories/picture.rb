FactoryGirl.define do
  factory :picture do
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/app.png')))
  end
end
