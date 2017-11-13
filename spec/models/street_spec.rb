require 'rails_helper'

RSpec.describe Street, type: :model do
  it { should belong_to :device }
end
