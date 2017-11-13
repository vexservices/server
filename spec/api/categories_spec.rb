require 'rails_helper'

RSpec.describe 'Categories' do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  let(:category) { create(:category, store: corporate) }

  before(:each) { category }

  it 'index' do
    get api_categories_path, nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/index')
  end

  it 'new' do
    get new_api_category_path, nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/new')
  end

  it 'create' do
    post api_categories_path, { category: { name: 'New API Category' } }, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/show')

  end

  it 'show' do
    get api_category_path(category), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/show')
  end

  it 'edit' do
    get edit_api_category_path(category), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/edit')
  end

  it 'update' do
    put api_category_path(category), { category: { name: 'API Category' } }, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('categories/show')
  end

  it 'destroy' do
    delete api_category_path(category), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end
end
