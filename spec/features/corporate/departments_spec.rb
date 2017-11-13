# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Departments', type: :feature do
  let(:corporate)  { create(:store, :ready) }
  let(:user)       { create(:user, store: corporate) }
  let(:department) { create(:department, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    department
  end

  it 'create' do
    visit departments_path(locale: :en)

    click_on 'New Department', match: :first

    fill_in :department_name, with: Faker::Name.name

    click_on 'Create Department'

    expect(page).to have_content('Department was successfully created!')
    expect(current_path).to eq departments_path(locale: :en)
  end

  it 'edit' do
    visit departments_path(locale: :en)

    click_on 'edit'

    fill_in :department_name, with: Faker::Name.name

    click_on 'Update Department'

    expect(page).to have_content('Department was successfully updated!')
    expect(current_path).to eq departments_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Department' }
    let(:url)   { departments_path(locale: :en) }
  end
end
