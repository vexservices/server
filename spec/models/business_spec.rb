require 'rails_helper'

RSpec.describe Business, type: :model do
  let(:business) { create(:business) }

  it { should have_many :images }

  it { should validate_presence_of :name }
end
