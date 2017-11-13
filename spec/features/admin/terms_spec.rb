# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Terms', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:term)
  end

  it 'edit' do
    visit edit_admin_term_path(locale: :en)

    fill_in :term_version, with: '1.1'
    fill_in :term_text, with: 'New Terms'

    click_on 'Update Term'

    expect(page).to have_content('Term was successfully updated!')
    expect(current_path).to eq edit_admin_term_path(locale: :en)
  end
end
