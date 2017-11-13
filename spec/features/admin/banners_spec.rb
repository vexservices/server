# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Banners', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:banner)
  end

  it_behaves_like 'manage banners'

  it_behaves_like "is deletable" do
    let(:klass) { 'Banner' }
    let(:url)   { admin_banners_path(locale: :en) }
  end
end
