require 'rails_helper'

RSpec.describe 'Devices' do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  let(:device) { create(:device, store: corporate, user: user) }

  before(:each) { device }

  it 'create' do
    post api_devices_path, { device: { push_token: '12345678', kind: '1' } }, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('devices/show')
  end

  it 'show' do
    get api_device_path(device), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('devices/show')
  end

  it 'update' do
    put api_device_path(device), { device: { token: nil } }, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('devices/show')
  end
end
