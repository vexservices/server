# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Corporates', type: :feature do
  let(:admin)  { create(:admin) }
  let(:paypal) { create(:paypal) }

  before(:each) do
    login_as(admin, scope: :admin)

    paypal
  end

  it_behaves_like 'manage paypals'

  it_behaves_like "is deletable" do
    let(:klass) { 'PayPal' }
    let(:url)   { admin_paypals_path(locale: :en) }
  end
end
