# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Business', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:business)
  end

  it 'create' do
    visit admin_businesses_path(locale: :en)

    click_on 'New Business', match: :first

    fill_in :business_name_en,    with: 'Business'
    fill_in :business_name_es,    with: 'Negocio'
    fill_in :business_name_pt_br, with: 'Negocio'

    click_on 'Create Business'

    expect(page).to have_content('Business was successfully created!')
  end

  it 'edit' do
    visit admin_businesses_path(locale: :en)

    click_on 'edit', match: :first

    fill_in :business_name_en,    with: 'Business'
    fill_in :business_name_es,    with: 'Negocio'
    fill_in :business_name_pt_br, with: 'Negocio'

    click_on 'Update Business'

    expect(page).to have_content('Business was successfully updated!')
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Business' }
    let(:url)   { admin_businesses_path(locale: :en) }
  end
end
