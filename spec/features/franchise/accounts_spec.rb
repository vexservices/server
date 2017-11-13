# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Admins', type: :feature do
  let(:franchise) { create(:franchise) }
  let(:admin)     { create(:admin, franchise: franchise) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  it 'edit' do
    visit edit_admin_account_path(locale: :en)

    fill_in :franchise_name, with: 'New Franchise'
    fill_in :franchise_email, with: Faker::Internet.email
    fill_in :franchise_mx_record, with: 'my_mx_record.com'
    fill_in :franchise_subdomain, with: 'subdomain'
    fill_in :franchise_domain, with: 'franchise.local'

    click_on 'Update Franchise'

    expect(page).to have_content('Franchise was successfully updated!')
    expect(current_path).to eq edit_admin_account_path(locale: :en)
  end
end
