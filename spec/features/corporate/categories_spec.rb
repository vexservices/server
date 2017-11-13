# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:category)  { create(:category, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    category
  end

  it 'create' do
    visit categories_path(locale: :en)

    click_on 'New Category', match: :first

    fill_in :category_name, with: Faker::Name.name

    click_on 'Create Category'

    expect(page).to have_content('Category was successfully created!')
    expect(current_path).to eq categories_path(locale: :en)
  end

  it 'edit' do
    visit categories_path(locale: :en)

    click_on 'edit'

    fill_in :category_name, with: Faker::Name.name

    click_on 'Update Category'

    expect(page).to have_content('Category was successfully updated!')
    expect(current_path).to eq categories_path(locale: :en)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Category' }
    let(:url)   { categories_path(locale: :en) }
  end
end
