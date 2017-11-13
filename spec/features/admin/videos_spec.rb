# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Videos', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)

    create(:video)
  end

  it_behaves_like 'manage videos'

  it_behaves_like "is deletable" do
    let(:klass) { 'Video' }
    let(:url)   { admin_videos_path(locale: :en) }
  end
end
