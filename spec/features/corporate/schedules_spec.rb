# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Schedules', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:product)   { create(:product, store: corporate) }
  let(:schedule)  { create(:schedule, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    schedule
    product
  end

  it 'create', :js do
    visit products_path(locale: :en)

    check "product_id_#{ product.id }"

    click_on 'Schedule'
    click_on 'Create Schedule'

    expect(page).to have_content('Schedule was successfully created!')
  end

  it 'edit' do
    visit edit_schedule_path(schedule, locale: :en)

    check "product_id_#{ product.id }"
    click_on 'Update Schedule'

    expect(page).to have_content('Schedule was successfully updated!')
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Schedule' }
    let(:url)   { schedules_path(locale: :en) }
  end
end
