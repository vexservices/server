require 'rails_helper'

RSpec.describe Property, type: :model do
  it { should belong_to :product }

  it { should validate_presence_of :name }
  it { should validate_presence_of :value }
end
