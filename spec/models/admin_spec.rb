require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { create(:admin) }
  let(:admin_franchise) { create(:admin, :with_franchise) }

  it { should belong_to :franchise }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end

  context '#belongs_to_franchise?' do
    it 'be false' do
      expect(admin.belongs_to_franchise?).to be_falsey
    end

    it 'be true' do
      expect(admin_franchise.belongs_to_franchise?).to be_truthy
    end
  end
end
