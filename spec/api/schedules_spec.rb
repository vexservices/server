require 'rails_helper'

RSpec.describe 'Schedules' do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  let(:schedule) { create(:schedule, store: corporate) }
  let(:product)  { create(:product, store: corporate) }

  before(:each) { product }

  it 'index' do
    get api_schedules_path, nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('schedules/index')
  end

  it 'create' do
    data = {
      schedule: {
        initial: "2015-01-01 14:00:00",
        final: "2015-01-05 14:00:00",
        run_at: "2015-01-01 15:00:00",
        product_ids: [product.id]
      }
    }

    post api_schedules_path, data, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('schedules/show')

  end

  it 'show' do
    get api_schedule_path(schedule), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('schedules/show')
  end

  it 'destroy' do
    delete api_schedule_path(schedule), nil, request_header(user)

    expect(response.status).to eq 200
    expect(response).to match_response_schema('success')
  end
end
