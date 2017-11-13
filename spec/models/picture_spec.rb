require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should belong_to :imageable }
  it { should validate_presence_of :file }
end
