# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Sellers', type: :feature do
  let(:distribuitor) { create(:seller) }
  let(:seller)       { create(:seller, seller: distribuitor) }

  before(:each) do
    login_as(distribuitor, scope: :seller)

    seller
  end

  it 'create' do
    visit seller_sellers_path(locale: :en)

    click_on 'New Distributor', match: :first

    fill_in :seller_name,  with: Faker::Name.name
    fill_in :seller_email, with: Faker::Internet.email
    fill_in :seller_password, with: '12345678'
    fill_in :seller_password_confirmation, with: '12345678'
    fill_in :seller_cell_phone, with: Faker::PhoneNumber.cell_phone
    fill_in :seller_phone,      with: Faker::PhoneNumber.cell_phone
    fill_in :seller_commission,  with: distribuitor.commission

    click_on 'Create Distributor'

    expect(page).to have_content('Distributor was successfully created!')
    expect(current_path).to eq seller_sellers_path(locale: :en)
  end

  it 'edit' do
    visit edit_seller_seller_path(seller, locale: :en)

    fill_in :seller_name,       with: Faker::Name.name
    fill_in :seller_cell_phone, with: Faker::PhoneNumber.cell_phone

    click_on 'Update Distributor'

    expect(page).to have_content('Distributor was successfully updated!')
    expect(current_path).to eq seller_sellers_path(locale: :en)
  end

  it 'show' do
    visit seller_seller_path(seller, locale: :en)

    expect(page).to have_content(seller.number)
    expect(page).to have_content(seller.name)
    expect(page).to have_content(seller.email)
    expect(page).to have_content(seller.phone)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Distributor' }
    let(:url)   { seller_sellers_path(locale: :en) }
  end
end
