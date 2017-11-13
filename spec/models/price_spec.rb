require 'rails_helper'

RSpec.describe Price, type: :model do
  it { should belong_to :store }
  it { should belong_to :product }

  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).allow_nil }
  it { should validate_numericality_of(:regular_price).allow_nil }
end
