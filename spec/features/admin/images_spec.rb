# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Images', type: :feature do
  let(:admin) { create(:admin) }

  let(:corporate) { create(:store, :ready) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  it 'edit' do
    visit edit_admin_corporate_image_path(corporate, locale: :en)

    attach_file(:image_file, File.join(Rails.root, '/spec/files/app.png'))
    click_on 'Update App Logo'

    expect(page).to have_content('App Logo was successfully updated!')
  end
end
