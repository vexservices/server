require 'rails_helper'

RSpec.describe Seller, type: :model do
  let(:seller) { create(:seller) }
  let(:sub)    { build(:seller, :sub) }

  it { should belong_to :seller }
  it { should belong_to :franchise }

  it { should have_one :address }
  it { should have_one :bank }

  it { should have_many :stores }
  it { should have_many :sellers }

  it { should validate_presence_of :name }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :commission }
  it { should validate_presence_of :email }

  it { should accept_nested_attributes_for :address }
  it { should accept_nested_attributes_for :bank }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end

  it '#address_state' do
    should delegate_method(:address_state).to(:address).as(:state)
  end

  it '#address_city' do
    should delegate_method(:address_city).to(:address).as(:city)
  end

  it '#address_street' do
    should delegate_method(:address_street).to(:address).as(:street)
  end

  it '#address_zip' do
    should delegate_method(:address_zip).to(:address).as(:zip)
  end

  it '#address_country' do
    should delegate_method(:address_country).to(:address).as(:country)
  end

  it '#seller_brazil?' do
    should delegate_method(:seller_brazil?).to(:seller).as(:brazil?)
  end

  it '#seller_name' do
    should delegate_method(:seller_name).to(:seller).as(:name)
  end

  it '#master?' do
    expect(seller.master?).to be_truthy
  end

  it '#master?' do
    expect(sub.master?).to be_falsey
  end

  it '#brazil?' do
    expect(seller.brazil?).to be_falsey
  end

  it '#is_brazilian?' do
    expect(seller.is_brazilian?).to be_falsey
  end

  it '#name_with_number' do
    expect(seller.name_with_number).to eq "#{ seller.number } - #{ seller.name }"
  end
end
