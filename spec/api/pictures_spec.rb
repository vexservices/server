require 'rails_helper'

RSpec.describe 'Pictures' do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  let(:product) { create(:product, store: corporate) }
  let(:picture) { create(:picture, imageable: product) }

  before(:each) { picture }

  it 'create' do
    file = Base64.encode64(File.open(File.join(Rails.root, '/spec/files/app.png'), "rb").read)

    post api_product_pictures_path(product), { file: file }, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('picture')
  end

  it 'show' do
    get api_product_picture_path(product, picture), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('picture')
  end

  it 'destroy' do
    delete api_product_picture_path(product, picture), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end
end
