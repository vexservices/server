require 'rails_helper'

RSpec.describe 'Products' do
  let(:corporate) { create(:store, :ready) }
  let(:store)     { create(:store, :branch_store, store: corporate) }
  let(:user)      { create(:user, store: corporate) }

  let(:product)   { create(:product, store: corporate) }
  let(:published) { create(:product, store: corporate, show_all: true) }

  before(:each) do
    product
    store
  end

  it 'index' do
    get api_products_path, nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/index')
  end

  it 'new' do
    get new_api_product_path, nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/new')
  end

  it 'create' do
    data = { product: { name: "Product By API", description:"Description here", regular_price:"100", price:"50" } }

    post api_products_path, data, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/show')

  end

  it 'show' do
    get api_product_path(product), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/show')
  end

  it 'edit' do
    get edit_api_product_path(product), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/edit')
  end

  it 'update' do
    data = { product: { name: "New Product Name", description:" New Description", regular_price:"120", price:"75" } }

    put api_product_path(product), data, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('products/show')
  end

  it 'destroy' do
    delete api_product_path(product), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end

  it 'publish' do
    post publish_api_product_path(product), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end

  it 'unpublish' do
    post unpublish_api_product_path(published), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end

  it 'publish_all' do
    post publish_all_api_product_path(product), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end

  it 'unpublish_all' do
    post unpublish_all_api_product_path(published), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end
end
