require 'rails_helper'

RSpec.describe Change, type: :model do
  it { should belong_to :changeable }

  # it '#changeable_name' do
  #   should delegate_method(:changeable_name).to(:changeable).as(:name)
  # end
end
