# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Apps', type: :feature do
  let(:admin) { create(:admin) }
  let(:store) { create(:store) }
  let(:app)   { store.app }

  before(:each) do
    login_as(admin, scope: :admin)

    store
  end

  it_behaves_like 'manage apps'
end
