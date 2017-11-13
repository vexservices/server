# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let(:seller) { create(:seller) }

  before(:each) { login_as(seller, scope: :seller) }

  it 'edit' do
    visit edit_seller_profile_path(locale: :en)

    fill_in :seller_name, with: Faker::Name.name
    fill_in :seller_password, with: '87654321'
    fill_in :seller_password_confirmation, with: '87654321'
    fill_in :seller_cell_phone, with: Faker::PhoneNumber.cell_phone
    fill_in :seller_phone, with: Faker::PhoneNumber.cell_phone
    fill_in :seller_document, with: Faker::Lorem.characters(10)

    fill_in :seller_address_attributes_state,   with: Faker::Address.state
    fill_in :seller_address_attributes_street,  with: Faker::Address.street_address
    fill_in :seller_address_attributes_city,    with: Faker::Address.city
    fill_in :seller_address_attributes_zip,     with: Faker::Address.zip

    click_on 'Update Distributor'

    expect(page).to have_content('Profile was successfully updated!')
    expect(current_path).to eq edit_seller_profile_path(locale: :en)
  end
end
