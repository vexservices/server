require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should belong_to :store }
  it { should have_and_belong_to_many :stores }

  describe 'validations' do
    subject { FactoryGirl.build(:client) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
  end
end
