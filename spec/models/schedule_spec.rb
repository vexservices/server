require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { should belong_to :store }
  it { should have_and_belong_to_many :products }

  it { should validate_presence_of :initial }
  it { should validate_presence_of :final }
  it { should validate_presence_of :run_at }
end
