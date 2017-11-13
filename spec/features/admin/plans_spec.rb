# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Plans', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:plan)
  end

  it_behaves_like 'manage plans'

  it_behaves_like "is deletable" do
    let(:klass) { 'Plan' }
    let(:url)   { admin_plans_path(locale: :en) }
  end
end
