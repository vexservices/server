# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Profiles', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  before(:each) { login_as(user, scope: :user) }

  it 'edit' do
    visit edit_profile_path(locale: :en)

    fill_in :user_password, with: '87654321'
    fill_in :user_password_confirmation, with: '87654321'

    click_on 'Update User'

    expect(page).to have_content('User was successfully updated!')
    expect(current_path).to eq edit_profile_path(locale: :en)
  end
end
