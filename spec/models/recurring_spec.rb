require 'rails_helper'

RSpec.describe Recurring, type: :model do
  it { should belong_to :store }
  it { should have_many :logs }
end
