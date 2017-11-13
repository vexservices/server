# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Recurrings', type: :feature do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }
  let(:recurring) { create(:recurring, store: corporate) }

  before(:each) do
    login_as(user, scope: :user)

    recurring
    create(:paypal)
  end

  it 'edit', :js do
    allow_any_instance_of(RecurringService).to receive(:cancel).and_return(true)

    visit plan_path(locale: :en)

    click_on 'Cancel Payment'
    confirm_dialog

    expect(page).to have_content('Payment was successfully canceled')
    expect(current_path).to eq plan_path(locale: :en)
  end
end
