# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Franchises', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:franchise)
  end

  it 'create' do
    visit admin_franchises_path(locale: :en)

    click_on 'New Franchise', match: :first

    fill_in :franchise_name, with: Faker::Company.name
    fill_in :franchise_email, with: Faker::Internet.email
    fill_in :franchise_subdomain, with: 'franchisesubdomain'
    fill_in :franchise_domain, with: Faker::Internet.domain_name

    fill_in :franchise_admins_attributes_0_name, with: Faker::Name.name
    fill_in :franchise_admins_attributes_0_email, with: Faker::Internet.email
    fill_in :franchise_admins_attributes_0_password, with: '12345678'
    fill_in :franchise_admins_attributes_0_password_confirmation, with: '12345678'

    click_on 'Create Franchise'

    expect(page).to have_content('Franchise was successfully created!')
    expect(current_path).to eq admin_franchises_path(locale: :en)
  end

  it 'edit' do
    visit admin_franchises_path(locale: :en)

    click_on 'edit', match: :first

    fill_in :franchise_name, with: 'Franchise'
    fill_in :franchise_email, with: Faker::Internet.email
    fill_in :franchise_mx_record, with: 'mx_record.local'
    fill_in :franchise_subdomain, with: 'franchises'
    fill_in :franchise_domain, with: 'franchises.local'

    click_on 'Update Franchise'

    expect(page).to have_content('Franchise was successfully updated!')
    expect(current_path).to eq admin_franchises_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Franchise' }
    let(:url)   { admin_franchises_path(locale: :en) }
  end
end
