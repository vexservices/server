require 'rails_helper'

RSpec.describe Message, :type => :model do
  let(:message) { create(:message) }

  it { should belong_to :store }
  it { should belong_to :device }

  it { should validate_presence_of :message }

  it '#by_device?' do
    expect(message.by_device?).to be_truthy
  end
end
