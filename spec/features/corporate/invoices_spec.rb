# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Invoices', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:invoice)   { create(:invoice, :paid, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    invoice
  end

  it 'index' do
    visit invoices_path(locale: :en)

    expect(page).to have_content(invoice.number)
    expect(page).to have_content(number_to_currency(invoice.value))
  end
end
