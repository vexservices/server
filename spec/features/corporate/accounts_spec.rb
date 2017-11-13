# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Accounts', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  before(:each) { login_as(user, scope: :user) }

  it 'edit' do
    visit edit_account_path(locale: :en)

    fill_in :store_name, with: Faker::Company.name
    fill_in :store_cell_phone, with: Faker::PhoneNumber.cell_phone

    fill_in :store_app_attributes_name, with: 'New App Name'

    fill_in :store_address_attributes_state,  with: Faker::Address.state
    fill_in :store_address_attributes_city,   with: Faker::Address.city
    fill_in :store_address_attributes_street, with: Faker::Address.street_address
    fill_in :store_address_attributes_zip,    with: Faker::Address.zip

    click_on 'Update Store'

    expect(page).to have_content('Store was successfully updated!')
    expect(current_path).to eq edit_account_path(locale: :en)
  end
end
