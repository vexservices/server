require 'rails_helper'

RSpec.describe Push, type: :model do
  it { should belong_to :store }
end
