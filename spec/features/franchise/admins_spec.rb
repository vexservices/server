# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Admins', type: :feature do
  let(:franchise) { create(:franchise) }
  let(:admin)     { create(:admin, franchise: franchise) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:admin, franchise: franchise)
  end

  it_behaves_like 'manage admins'

  it_behaves_like "is deletable" do
    let(:klass) { 'Admininstrator' }
    let(:url)   { admin_admins_path(locale: :en) }
  end
end
