require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:store)        { build(:store) }
  let(:branch_store) { create(:store, :branch_store, store: store) }

  it { should belong_to :franchise }
  it { should belong_to :store }
  it { should belong_to :department }
  it { should belong_to :seller }
  it { should belong_to :plan }
  it { should belong_to :app_logo }

  it { should have_one :address }
  it { should have_one :app }
  it { should have_one :image }

  it { should have_many :users }
  it { should have_many :categories }
  it { should have_many :products }
  it { should have_many :stores }
  it { should have_many :schedules }
  it { should have_many :publishes }
  it { should have_many :prices }
  it { should have_many :recurrings }
  it { should have_many :orders }
  it { should have_many :devices }
  it { should have_many :invoices }
  it { should have_many :sections }
  it { should have_many :jobs }
  it { should have_many :logs }

  it { should have_and_belong_to_many :departments }

  it { should validate_presence_of :name }
  it { should validate_presence_of :time_zone }
  it { should validate_presence_of :cell_phone }

  it { should accept_nested_attributes_for :address }
  it { should accept_nested_attributes_for :users }
  it { should accept_nested_attributes_for :app }

  it '#franchise_name' do
    should delegate_method(:franchise_name).to(:franchise).as(:name)
  end

  it '#address_state' do
    should delegate_method(:address_state).to(:address).as(:state)
  end

  it '#address_city' do
    should delegate_method(:address_city).to(:address).as(:city)
  end

  it '#address_street' do
    should delegate_method(:address_street).to(:address).as(:street)
  end

  it '#address_zip' do
    should delegate_method(:address_zip).to(:address).as(:zip)
  end

  it '#address_country' do
    should delegate_method(:address_country).to(:address).as(:country)
  end

  it '#plan_price' do
    should delegate_method(:plan_price).to(:plan).as(:price)
  end

  it '#plan_price_real' do
    should delegate_method(:plan_price_real).to(:plan).as(:price_real)
  end

  it '#plan_name' do
    should delegate_method(:plan_name).to(:plan).as(:name)
  end

  it '#plan_stores_limit' do
    should delegate_method(:plan_stores_limit).to(:plan).as(:stores_limit)
  end

  it '#plan_monthly_posts' do
    should delegate_method(:plan_monthly_posts).to(:plan).as(:monthly_posts)
  end

  it '#plan_chat_support?' do
    should delegate_method(:plan_chat_support?).to(:plan).as(:chat_support?)
  end

  it '#app_id' do
    should delegate_method(:app_id).to(:app).as(:id)
  end

  it '#app_name' do
    should delegate_method(:app_name).to(:app).as(:name)
  end

  it '#app_has_apple_certificate?' do
    should delegate_method(:app_has_apple_certificate?).to(:app).as(:has_apple_certificate?)
  end

  it '#app_has_google_api_key?' do
    should delegate_method(:app_has_google_api_key?).to(:app).as(:has_google_api_key?)
  end

  it '#app_apple_certificate' do
    should delegate_method(:app_apple_certificate).to(:app).as(:apple_certificate)
  end

  it '#app_apple_store_url' do
    should delegate_method(:app_apple_store_url).to(:app).as(:apple_store_url)
  end

  it '#app_ready?' do
    should delegate_method(:app_ready?).to(:app).as(:ready?)
  end

  it '#app_google_play_url' do
    should delegate_method(:app_google_play_url).to(:app).as(:google_play_url)
  end

  it '#app_google_api_key' do
    should delegate_method(:app_google_api_key).to(:app).as(:google_api_key)
  end

  it '#app_setup_cover?' do
    should delegate_method(:app_setup_cover?).to(:app).as(:setup_cover?)
  end

  it '#app_app_cover' do
    should delegate_method(:app_app_cover).to(:app).as(:app_cover)
  end

  it '#corporate_address_country' do
    should delegate_method(:corporate_address_country).to(:corporate).as(:address_country)
  end

  it '#corporate_plan_name' do
    should delegate_method(:corporate_plan_name).to(:corporate).as(:plan_name)
  end

  it '#corporate_plan_price' do
    should delegate_method(:corporate_plan_price).to(:corporate).as(:plan_price)
  end

  it '#corporate_plan_stores_limit' do
    should delegate_method(:corporate_plan_stores_limit).to(:corporate).as(:plan_stores_limit)
  end

  it '#corporate_plan_monthly_posts' do
    should delegate_method(:corporate_plan_monthly_posts).to(:corporate).as(:plan_monthly_posts)
  end

  it '#department_name' do
    should delegate_method(:department_name).to(:department).as(:name)
  end

  it '#seller_name' do
    should delegate_method(:seller_name).to(:seller).as(:name)
  end

  it '#franchise_trial_period' do
    should delegate_method(:franchise_trial_period).to(:franchise).as(:trial_period)
  end

  it '#money_currency' do
    expect(store.money_currency).to be_a Money::Currency
  end

  it '#money_delimiter' do
    expect(store.money_delimiter).to eq ','
  end

  it '#money_unit' do
    expect(store.money_unit).to eq '$'
  end

  it '#money_separator' do
    expect(store.money_separator).to eq '.'
  end

  it '#logo_or_default_url' do
    expect(store.logo_or_default_url).to eq 'store/thumb.png'
  end

  it '#corporate' do
    expect(store.corporate).to eq store
  end

  it '#corporate' do
    expect(branch_store.corporate).to eq store
  end

  it '#corporate' do
    expect(branch_store.corporate).to eq store
  end

  it '#setup_app_image?' do
    expect(store.setup_app_image?).to be_truthy
  end

  it '#use_recurring?' do
    expect(store.use_recurring?).to be_truthy
  end

  context '#inactive?' do
    it 'be false' do
      expect(store.inactive?).to be_falsey
    end

    it 'be true' do
      store.active = false

      expect(store.inactive?).to be_truthy
    end
  end

  context '#belongs_to_franchise?' do
    it 'be false' do
      expect(store.belongs_to_franchise?).to be_falsey
    end

    it 'be true' do
      store = create(:store, :with_franchise)

      expect(store.belongs_to_franchise?).to be_truthy
    end
  end

  context '#can_publish_product?' do
    it 'be false' do
      allow(store).to receive(:plan_monthly_posts) { 10 }
      allow(store).to receive(:publishes_count) { 10 }

      expect(store.can_publish_product?).to be_falsey
    end

    it 'be true' do
      allow(store).to receive(:plan_monthly_posts) { 20 }
      allow(store).to receive(:publishes_count) { 5 }

      expect(store.can_publish_product?).to be_truthy
    end
  end

  it '#publishes_count' do
    allow(Publish).to receive(:current_count_by_store) { 15 }
    expect(branch_store.publishes_count).to eq 15
  end

  context '#belongs_to_franchise?' do
    it 'be false' do
      store.plan_updated_at = DateTime.current - 10.days

      expect(store.belongs_to_franchise?).to be_falsey
    end

    it 'be true' do
      expect(store.can_update_plan?).to be_truthy
    end
  end

  context '#trial?' do
    it 'be false' do
      store.trial_at = DateTime.current - 40.days

      expect(store.trial?).to be_falsey
    end

    it 'be true' do
      expect(store.trial?).to be_truthy
    end
  end

  context '#trial_ending?' do
    it 'be false' do
      expect(store.trial_ending?).to be_falsey
    end

    it 'be true' do
      store.trial_at = DateTime.current + 5.days

      expect(store.trial_ending?).to be_truthy
    end
  end
end
