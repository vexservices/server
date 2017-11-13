FactoryGirl.define do
  factory :banner do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/app.png')))
    locale 'en'
  end
end
