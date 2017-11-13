# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Client', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let!(:client)   { create(:client, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)
  end

  it 'create' do
    visit clients_path(locale: :en)

    click_on 'New Client', match: :first

    fill_in :client_name,     with: Faker::Name.name
    fill_in :client_username, with: Faker::Name.name
    fill_in :client_password, with: '12345678'

    click_on 'Create Client'

    expect(page).to have_content('Client was successfully created!')
    expect(current_path).to eq clients_path(locale: :en)
  end

  it 'edit' do
    visit clients_path(locale: :en)

    click_on 'edit'

    fill_in :client_name, with: Faker::Name.name

    click_on 'Update Client'

    expect(page).to have_content('Client was successfully updated!')
    expect(current_path).to eq clients_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Client' }
    let(:url)   { clients_path(locale: :en) }
  end
end
