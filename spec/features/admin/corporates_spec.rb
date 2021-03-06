# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Corporates', type: :feature do
  let(:admin) { create(:admin) }
  let(:store) { create(:store) }

  before(:each) do
    login_as(admin, scope: :admin)

    store
  end

  it_behaves_like 'manage corporates'

  it_behaves_like "is deletable" do
    let(:klass) { 'Store' }
    let(:url)   { admin_corporates_path(locale: :en) }
  end
end
