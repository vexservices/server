require 'rails_helper'

RSpec.describe Franchise, type: :model do
  it { have_many :admins }
  it { have_many :plans }
  it { have_many :sellers }
  it { have_many :stores }
  it { have_many :banners }
  it { have_many :contacts }
  it { have_many :paypals }
  it { have_many :videos }

  describe 'validations' do
    subject { FactoryGirl.build(:franchise) }

    it { should accept_nested_attributes_for :admins }

    it { should validate_presence_of :name }
    it { should validate_presence_of :subdomain }
    it { should validate_presence_of :domain }

    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :subdomain }

    it { should validate_exclusion_of(:subdomain).in_array(['www', 'http', 'https', 'api']) }
  end
end
