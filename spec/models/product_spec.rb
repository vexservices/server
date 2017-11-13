require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to :category }
  it { should belong_to :store }
  it { should have_many :pictures }
  it { should have_many :publishes }
  it { should have_many :properties }
  it { should have_and_belong_to_many :schedules }
  it { should have_and_belong_to_many :stores }

  it { should accept_nested_attributes_for(:pictures).allow_destroy(true) }
  it { should accept_nested_attributes_for(:properties).allow_destroy(true) }

  describe 'validations' do
    subject { FactoryGirl.build(:product) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).allow_nil }
    it { should validate_numericality_of(:regular_price).allow_nil }
    it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
  end


  it '#category_name' do
    should delegate_method(:category_name).to(:category).as(:name)
  end

  it '#store_name' do
    should delegate_method(:store_name).to(:store).as(:name)
  end
end
