require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should belong_to :franchise }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :message }

  # TODO: Find way to fix this validation
  # it { should validate_length_of(:message).is_at_most(500) }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end
end
