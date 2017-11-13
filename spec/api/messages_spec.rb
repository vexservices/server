require 'rails_helper'

RSpec.describe 'Api::V1::Messages' do
  let(:store)   { create(:store) }
  let(:branch)  { create(:store, store: store) }
  let(:device)  { create(:device, store: store) }
  let(:message) { create(:message, store: store, device: device) }
  let(:user)    { create(:user, store: store) }

  before(:each) { message }

  context 'index' do
    it 'with device' do
      get api_device_messages_path(device), {}, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/index')
    end

    it 'with branch store' do
      get api_store_messages_path(branch), {}, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/index')
    end

    it 'without device' do
      get api_messages_path, {}, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/devices')
    end
  end

  it 'show' do
    get api_message_path(message), nil, request_header(user)
    expect(response.status).to eq 200
    expect(response).to match_response_schema('messages/show')
  end

  context 'create' do
    it 'with device' do
      post api_device_messages_path(device), { message: { message: 'Hello world.' } }, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/show')
    end

    it 'with branch store' do
      post api_store_messages_path(branch), { message: { message: 'Hello world.' }, device_id: device.id }, request_header(user)
      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/show')
    end
  end

  context 'unread' do
    it 'with device' do
      get unread_api_device_messages_path(device), {}, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/unread')
    end

    it 'with branch store' do
      get unread_api_store_messages_path(branch), {device_id: device.id}, request_header(user)
      expect(response.status).to eq 200
      expect(response).to match_response_schema('messages/unread')
    end
  end

  it 'stores' do
    get stores_api_messages_path, {}, request_header(user)
    expect(response.status).to eq 200
    expect(response).to match_response_schema('messages/stores')
  end
end
