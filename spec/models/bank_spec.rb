require 'rails_helper'

RSpec.describe Bank, type: :model do
  let(:address) { create(:address) }

  it { should belong_to :seller }

  it { should validate_presence_of :name }
  it { should validate_presence_of :agency }
  it { should validate_presence_of :number }
end
