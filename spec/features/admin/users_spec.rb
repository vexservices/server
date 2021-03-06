# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let(:admin)     { create(:admin) }
  let(:corporate) { create(:store) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:user, store: corporate)
  end

  context 'Corporate' do
    it_behaves_like 'manage users' do
      let(:url) { admin_corporate_path(corporate, locale: :en) }
    end

    it_behaves_like "is deletable" do
      let(:klass) { User }
      let(:url)   { admin_corporate_path(corporate, locale: :en) }
    end
  end

  context 'Branch Store' do
    let(:store) { create(:store, :branch_store, store: corporate) }

    before(:each) { create(:user, store: store) }

    it_behaves_like 'manage users' do
      let(:url) { admin_corporate_store_path(corporate, store, locale: :en) }
    end

    it_behaves_like "is deletable" do
      let(:klass) { 'User' }
      let(:url)   { admin_corporate_store_path(corporate, store, locale: :en) }
    end
  end
end
