require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should belong_to :store }

  it { should validate_presence_of :name }
  it { should validate_presence_of :file }
end
