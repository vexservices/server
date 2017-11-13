# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Departments', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:department, :super)
  end

  it 'create' do
    visit admin_departments_path(locale: :en)

    click_on 'New Department', match: :first

    fill_in :department_name, with: 'Department'
    fill_in :department_title_en, with: 'Department'
    fill_in :department_title_pt_br, with: 'Departmento'
    fill_in :department_title_es, with: 'Departamento'

    click_on 'Create Department'

    expect(page).to have_content('Department was successfully created!')
    expect(current_path).to eq admin_departments_path(locale: :en)
  end

  it 'edit' do
    visit admin_departments_path(locale: :en)

    click_on 'edit', match: :first

    fill_in :department_name, with: 'New Department'
    fill_in :department_title_en, with: 'New Department'
    fill_in :department_title_pt_br, with: 'Novo Departmento'
    fill_in :department_title_es, with: 'Nuevo Departamento'

    click_on 'Update Department'

    expect(page).to have_content('Department was successfully updated!')
    expect(current_path).to eq admin_departments_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Department' }
    let(:url)   { admin_departments_path(locale: :en) }
  end
end
