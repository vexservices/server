require 'rails_helper'

RSpec.describe App, type: :model do
  let(:app)           { create(:app, :with_store) }
  let(:app_with_logo) { create(:app, :with_store, :logo) }
  let(:app_pendent)   { create(:app, :with_store, :pendent) }

  it { should belong_to :store }

  it { should validate_presence_of :name }

  it '#store_address' do
    should delegate_method(:store_address).to(:store).as(:address)
  end

  it '#store_name' do
    should delegate_method(:store_name).to(:store).as(:name)
  end

  it '#store_has_app_image?' do
    should delegate_method(:store_has_app_image?).to(:store).as(:has_app_image?)
  end

  it '#google_api_key_short' do
    expect(app.google_api_key_short).to eq "#{app.google_api_key[0..20]}..."
  end

  it '#ready?' do
    expect(app.ready?).to be_truthy
  end

  it '#google_api_key?' do
    expect(app.google_api_key?).to be_truthy
  end

  it '#has_apple_certificate?' do
    expect(app.has_apple_certificate?).to be_falsey
  end

  it '#language' do
    expect(app.language).to eq app.store_address.country
  end

  it '#language' do
    expect(app.language).to eq app.store_address.country
  end

  context '#setup_cover?' do
    it 'be true' do
      expect(app.setup_cover?).to be_falsey
    end

    it 'be false' do
      expect(app_with_logo.setup_cover?).to be_falsey
    end

    it 'be false' do
      expect(app_pendent.setup_cover?).to be_truthy
    end
  end
end
