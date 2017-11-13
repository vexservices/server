require 'rails_helper'

RSpec.describe Pin, type: :model do
  it { should have_many :pictures }
end
