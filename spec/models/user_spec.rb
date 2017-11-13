require 'rails_helper'

RSpec.describe User, type: :model do
  let(:admin) { create(:admin) }

  it { should belong_to :store }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it '#store_corporate?' do
    should delegate_method(:store_corporate?).to(:store).as(:corporate?)
  end

  it '#store_store_id' do
    should delegate_method(:store_store_id).to(:store).as(:store_id)
  end
end
