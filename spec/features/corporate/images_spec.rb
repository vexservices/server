# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Images', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:business)  { create(:business, name: 'Business') }

  before(:each) { login_as(user, scope: :user) }

  context 'edit' do
    it 'upload logo' do
      visit edit_image_path(locale: :en)

      attach_file(:image_file, File.join(Rails.root, '/spec/files/app.png'))
      click_on 'Click here to upload your logo file.'

      expect(page).to have_content('Logo was successfully updated!')
    end

    it 'choose default logos', :js do
      business

      visit edit_image_path(locale: :en)

      select business.name, from: 'Category'
      click_on 'Search'

      click_on 'Select', match: :first
      confirm_dialog

      expect(page).to have_content('Logo was successfully updated!')
    end
  end
end
