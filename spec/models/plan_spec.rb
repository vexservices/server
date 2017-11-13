require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:plan) { create(:plan) }

  it { should belong_to :franchise }

  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should validate_presence_of :monthly_posts }

  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:price_real) }
  it { should validate_numericality_of(:monthly_posts) }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end

  it '#name_with_price' do
    expect(plan.name_with_price).to eq "#{ plan.name } - #{ plan.price }"
  end
end
