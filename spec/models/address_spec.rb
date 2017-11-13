require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { create(:address) }

  it { should belong_to :store }
  it { should belong_to :seller }

  it { should validate_presence_of :street }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :country }
  it { should validate_presence_of :zip }

  it '#full_address' do
    full_address = "#{ address.street }, #{ address.city }, #{ address.state } - #{ address.country }"

    expect(address.full_address).to eq full_address
  end

  context '#address_changed?' do
    it 'be false' do
      expect(address.address_changed?).to be_falsey
    end

    it 'be true' do
      address.street = Faker::Address.street_address

      expect(address.address_changed?).to be_truthy
    end
  end

  context '#has_coordenates?' do
    it 'be false' do
      address.latitude = nil
      address.longitude = nil

      expect(address.has_coordenates?).to be_falsey
    end

    it 'be true' do
      expect(address.has_coordenates?).to be_truthy
    end
  end
end
