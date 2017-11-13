require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should belong_to :recurring }
end
