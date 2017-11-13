# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Report::Products', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:product)   { create(:product, store: corporate) }
  let(:publish)   { create(:publish, :published, product: product, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    publish
  end

  it 'index' do
    visit report_products_path(locale: :en)

    expect(page).to have_content(publish.product_name)
    expect(page).to have_content(number_to_currency(publish.regular_price))
    expect(page).to have_content(number_to_currency(publish.price))
  end
end
