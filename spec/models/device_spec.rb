require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:device) { build(:device, :apple_token) }

  it { should belong_to :store }
  it { should have_and_belong_to_many :stores }

  it '#token_with_mask' do
    expect(device.token_with_mask).to eq '<11111111 22222222 33333333 44444444 55555555 66666666 77777777 88888888>'
  end

  it '#generate_token' do
    expect(device.token).to be_nil
  end
end
