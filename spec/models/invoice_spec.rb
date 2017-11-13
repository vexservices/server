require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:invoice) { build(:invoice, plan_name: nil) }

  context '#set_number?' do
    it 'is nil' do
      expect(invoice.number).to be_nil
    end

    it 'is present' do
      invoice.save
      expect(invoice.number).to_not be_nil
    end
  end

  context '#plan_name' do
    it 'is nil' do
      expect(invoice.plan_name).to be_nil
    end

    it 'is present' do
      invoice.save
      expect(invoice.plan_name).to_not be_nil
    end
  end
end
