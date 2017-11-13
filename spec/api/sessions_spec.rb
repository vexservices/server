require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user)  { create(:user) }

  context 'Login' do
    it 'valid user' do
      post api_sessions_path,  { user: { email: user.email, password: user.password } }

      expect(response.status).to eq 200
      expect(response).to match_response_schema('login_success')
    end

    it 'invalid user' do
      post api_sessions_path,  { user: { email: 'user@invalid.com', password: '12345678' } }

      expect(response.status).to eq 401
      expect(response).to match_response_schema('login_failure')
    end
  end

  context 'Logout' do
    it 'logout user' do
      delete api_sessions_path, nil, request_header(user)

      expect(response.status).to eq 200
      expect(response).to match_response_schema('logout')
    end
  end
end
