# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Sellers', type: :feature do
  let(:franchise) { create(:franchise) }
  let(:admin)     { create(:admin, franchise: franchise) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:seller, franchise: franchise)
  end

  it_behaves_like 'manage sellers'

  it_behaves_like "is deletable" do
    let(:klass) { 'Distributor' }
    let(:url)   { admin_sellers_path(locale: :en) }
  end
end
