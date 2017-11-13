# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Orders', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)
  end

  it 'create' do
    allow_any_instance_of(Order).to receive(:make_recurring).and_return(true)

    visit new_order_path(locale: :en)

    fill_in :order_first_name, with: Faker::Name.first_name
    fill_in :order_last_name, with: Faker::Name.last_name

    select 'Visa', from: :order_card_brand

    fill_in :order_card_number, with: '4242424242424242'
    fill_in :order_card_verification, with: '000'

    click_on 'Submit'

    expect(page).to have_content('Payment was successfully saved')
  end
end
