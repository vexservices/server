# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let(:corporate)    { create(:store, :ready) }
  let(:current_user) { create(:user, store: corporate) }
  let(:user)         { create(:user, store: corporate) }

  before(:each) do
    login_as(current_user, scope: :user)

    user
  end

  it 'create' do
    visit users_path(locale: :en)

    click_on 'New User', match: :first

    fill_in :user_name,     with: Faker::Name.name
    fill_in :user_email,    with: Faker::Internet.email
    fill_in :user_password, with: '12345678'
    fill_in :user_password_confirmation, with: '12345678'

    click_on 'Create User'

    expect(page).to have_content('User was successfully created!')
    expect(current_path).to eq users_path(locale: :en)
  end

  it 'edit' do
    visit edit_user_path(user, locale: :en)

    fill_in :user_password, with: '87654321'
    fill_in :user_password_confirmation, with: '87654321'

    click_on 'Update User'

    expect(page).to have_content('User was successfully updated!')
    expect(current_path).to eq users_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'User' }
    let(:url)   { users_path(locale: :en) }
  end
end
