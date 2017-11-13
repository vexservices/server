require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to :store }
  it { should have_many :products }
  it { should have_many :categories }

  it { should validate_presence_of :name }
end
