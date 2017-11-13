# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Plans', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:plan)      { create(:plan) }

  before(:each) do
    login_as(user, scope: :user)

    plan
  end

  it 'edit', :js do
    visit plan_path(locale: :en)

    click_on 'Select Plan'
    confirm_dialog

    expect(page).to have_content('Plan was successfully updated!')
    expect(page).to have_content('Plan change limit exceeded. Only one plan change permitted per month.')
  end
end
