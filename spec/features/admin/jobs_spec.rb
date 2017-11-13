# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Apps', type: :feature do
  let(:admin) { create(:admin) }
  let(:store) { create(:store) }
  let(:job)   { create(:job, store: store) }

  before(:each) do
    login_as(admin, scope: :admin)

    job
  end

  it 'create' do
    visit admin_store_jobs_path(store, locale: :en)

    click_on 'New Job', match: :first
    attach_file(:job_file, File.join(Rails.root, '/spec/files/product_sample.csv'))
    click_on 'Create Job'

    expect(page).to have_content('Job was successfully created!')
    expect(current_path).to eq admin_store_jobs_path(store, locale: :en)
  end

  it 'show' do
    visit admin_store_job_path(store, job, locale: :en)
    expect(page).to have_content(job.name)
  end

  it_behaves_like "is deletable" do
    let(:klass) { 'Job' }
    let(:url)   { admin_store_jobs_path(store, locale: :en) }
  end
end
