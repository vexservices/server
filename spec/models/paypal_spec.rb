require 'rails_helper'

RSpec.describe Paypal, type: :model do
  it { should validate_presence_of :login }
  it { should validate_presence_of :password }
  it { should validate_presence_of :partner }
  it { should validate_presence_of :country }
end
