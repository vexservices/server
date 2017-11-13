# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Products', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let!(:store)    { create(:store, :branch_store, store: corporate) }
  let(:user)      { create(:user, store: corporate) }
  let!(:product)  { create(:product, store: corporate) }
  let(:published) { create(:product, store: corporate, show_all: true) }
  let(:category)  { create(:category, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)
  end

  it 'create' do
    category

    visit products_path(locale: :en)

    click_on 'New Product', match: :first

    fill_in :product_code, with: Faker::Number.number(4)
    fill_in :product_name, with: Faker::Commerce.product_name

    select category.name, from: :product_category_id

    fill_in :product_description,    with: Faker::Lorem.sentence
    fill_in :product_contact_info,   with: Faker::Lorem.sentence
    fill_in :product_regular_price,  with: Faker::Commerce.price
    fill_in :product_price,          with: Faker::Commerce.price

    click_on 'Save Product'

    expect(page).to have_content('Product was successfully created!')
  end

  it 'edit' do
    category

    visit products_path(locale: :en)

    click_on 'edit'

    fill_in :product_code, with: Faker::Number.number(4)
    fill_in :product_name, with: Faker::Commerce.product_name

    select category.name, from: :product_category_id

    fill_in :product_description,    with: Faker::Lorem.sentence
    fill_in :product_contact_info,   with: Faker::Lorem.sentence
    fill_in :product_regular_price,  with: Faker::Commerce.price
    fill_in :product_price,          with: Faker::Commerce.price

    click_on 'Save Product'

    expect(page).to have_content('Product was successfully updated!')
  end

  it 'show' do
    visit product_path(product, locale: :en)

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
  end

  it_behaves_like "is deletable" do
    let(:klass) { Product }
    let(:url)   { products_path(locale: :en) }
  end

  it 'publish', :js do
    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Publish'

    expect(page).to have_content('Product was successfully published!')
  end

  it 'unpublish', :js do
    create(:publish, :published, product: product, store: corporate)

    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Unpublish'

    expect(page).to have_content('Product was successfully unpublished!')
  end

  it 'feature code a', :js do
    create(:publish, :published, product: product, store: corporate)

    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Feature Code A'

    expect(page).to have_content('Product was successfully featured!')
  end

  it 'feature code b', :js do
    create(:publish, :published, product: product, store: corporate)

    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Feature Code B'

    expect(page).to have_content('Product was successfully featured!')
  end

  it 'feature code c', :js do
    create(:publish, :published, product: product, store: corporate)

    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Feature Code C'

    expect(page).to have_content('Product was successfully featured!')
  end

  it 'publish_all', :js do
    visit products_path(locale: :en)

    click_on 'Actions'
    click_on 'Post in All branch locations'

    expect(page).to have_content('Product was successfully published!')
  end

  it 'unpublish_all', :js do
    published

    visit products_path(locale: :en)

    within "tr#product_#{ published.id }" do
      click_on 'Actions'
      click_on 'Unpost in All branch locations'
    end

    expect(page).to have_content('Product was successfully unpublished!')
  end
end
