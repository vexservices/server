require 'rails_helper'

RSpec.describe 'Stores' do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  it 'show' do
    get api_store_path(corporate), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('stores/show')
  end
end
