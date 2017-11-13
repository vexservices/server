require 'rails_helper'

RSpec.describe Banner, type: :model do

  it { belong_to :franchise }
  it { should validate_presence_of :image }
  it { should validate_presence_of :locale }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end
end
