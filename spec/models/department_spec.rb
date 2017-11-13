require 'rails_helper'

RSpec.describe Department, type: :model do
  it { should belong_to :store }
  it { should belong_to :department }
  it { should have_many :departments }
  it { should have_many :corporates }
  it { should have_and_belong_to_many :stores }

  describe 'validations' do
    subject { FactoryGirl.build(:department) }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
  end
end
