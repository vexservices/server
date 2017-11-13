# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Contacts', type: :feature do
  let(:admin)   { create(:admin) }
  let(:contact) { create(:contact) }

  before(:each) do
    login_as(admin, scope: :admin)

    contact
  end

  it_behaves_like 'manage contacts'

  it_behaves_like "is deletable" do
    let(:klass) { 'Contact' }
    let(:url)   { admin_contacts_path(locale: :en) }
  end
end
