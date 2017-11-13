# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Stores', type: :feature do
  let(:corporate)  { create(:store, :ready) }
  let(:user)       { create(:user, store: corporate) }
  let(:store)      { create(:store, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    store
  end

  it 'create' do
    visit stores_path(locale: :en)

    click_on 'New Store', match: :first

    fill_in :store_name, with: Faker::Company.name
    fill_in :store_cell_phone, with: Faker::PhoneNumber.cell_phone

    select  'Pacific Time (US & Canada)', from: :store_time_zone

    fill_in :store_address_attributes_state,  with: Faker::Address.state
    fill_in :store_address_attributes_city,   with: Faker::Address.city
    fill_in :store_address_attributes_street, with: Faker::Address.street_address
    fill_in :store_address_attributes_zip,    with: Faker::Address.zip

    fill_in :store_users_attributes_0_name, with: Faker::Name.name
    fill_in :store_users_attributes_0_email, with: Faker::Internet.email
    fill_in :store_users_attributes_0_password, with: '12345678'
    fill_in :store_users_attributes_0_password_confirmation, with: '12345678'


    click_on 'Create Store'

    expect(page).to have_content('Store was successfully created!')
    expect(current_path).to eq stores_path(locale: :en)
  end

  it 'edit' do
    visit edit_store_path(store, locale: :en)

    fill_in :store_name, with: Faker::Company.name
    fill_in :store_cell_phone, with: Faker::PhoneNumber.cell_phone

    click_on 'Update Store'

    expect(page).to have_content('Store was successfully updated!')
    expect(current_path).to eq stores_path(locale: :en)
  end

  it 'show' do
    visit store_path(store, locale: :en)

    expect(page).to have_content(store.number)
    expect(page).to have_content(store.name)
    expect(page).to have_content(store.phone)

    expect(page).to have_content(store.address_state)
    expect(page).to have_content(store.address_city)
    expect(page).to have_content(store.address_street)
    expect(page).to have_content(store.address_zip)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Store' }
    let(:url)   { stores_path(locale: :en) }
  end
end
