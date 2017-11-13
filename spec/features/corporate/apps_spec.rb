# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Apps', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  before(:each) { login_as(user, scope: :user) }

  it 'change cover page image' do
    visit edit_app_path(locale: :en)

    attach_file(:app_app_cover, File.join(Rails.root, '/spec/files/app.png'))
    click_on I18n.t('buttons.upload_logo')

    expect(page).to have_content('App was successfully updated!')
  end
end
