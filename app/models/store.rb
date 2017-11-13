class Store < ActiveRecord::Base
  has_paper_trail

  attr_accessor :admin_update

  scope :corporates,     -> { where(corporate: true) }
  scope :find_by_number, ->(term) { where(number: term) }
  scope :actives,        -> { where(blocked: false) }

  scope :with_messages, -> do
    distinct
      .select('stores.id, stores.name, stores.logo, COUNT(messages.id) AS messages_count')
      .joins(
        <<-SQL
          LEFT JOIN messages ON messages.store_id = stores.id
          AND messages.read_at IS NULL
          AND messages.kind = 1
        SQL
      )
      .group('stores.id, stores.name')
      .order('COUNT(messages.id) desc')
  end

  has_ancestry cache_depth: true

  belongs_to :app_logo, class_name: 'Image'
  belongs_to :business
  belongs_to :department
  belongs_to :franchise
  belongs_to :plan
  belongs_to :seller, counter_cache: true
  belongs_to :store, counter_cache: true

  has_one :address, dependent: :delete
  has_one :app,     dependent: :delete
  has_one :image,   dependent: :delete

  has_many :categories, dependent: :delete_all
  has_many :clients,    dependent: :delete_all
  has_many :devices,    dependent: :delete_all
  has_many :invoices
  has_many :jobs,       dependent: :delete_all
  has_many :logs, as: :changeable, class_name: 'Change'
  has_many :messages,      dependent: :delete_all
  has_many :notifications, dependent: :delete_all
  has_many :orders,        dependent: :delete_all
  has_many :prices,        dependent: :delete_all
  has_many :products,      dependent: :delete_all
  has_many :publishes,     dependent: :delete_all
  has_many :recurrings,    dependent: :delete_all
  has_many :sections,      dependent: :delete_all, class_name: 'Department'
  has_many :schedules,     dependent: :delete_all
  has_many :stores,        dependent: :delete_all
  has_many :users,         dependent: :delete_all

  has_and_belongs_to_many :departments

  mount_uploader :logo, LogoUploader

  validates  :name, :time_zone, :cell_phone, presence: true

  validates :official_email, format: { with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ },
    allow_blank: true

  accepts_nested_attributes_for :address, :users, :app

  with_options prefix: true, allow_nil: true do |o|
    # Address
    o.delegate :state, :city, :street, :zip, :country, :latitude, :longitude,
      :country, to: :address

    # Plan
    o.delegate :name, :price, :stores_limit, :monthly_posts, :chat_support?,
      :price_real, to: :plan

    # App
    o.delegate :name, :apple_certificate, :apple_store_url, :ready?,
      :google_play_url, :google_api_key, :setup_cover?, :app_cover,
      :has_apple_certificate?, :has_google_api_key?, :id, :test_mode?,
      :authenticate?, to: :app

    # Corporate
    o.delegate :address_country, :plan_name, :plan_price, :plan_stores_limit,
      :plan_monthly_posts, to: :corporate

    o.delegate :trial_period, to: :franchise
    o.delegate :key,  to: :business
    o.delegate :name, to: :seller
    o.delegate :name, to: :department
    o.delegate :name, to: :sub_department
    o.delegate :name, :email, :domain, to: :franchise
  end

  has_enumeration_for :payment_option, with: PaymentOptions, create_helpers: true

  def emails
    @emails ||= users.pluck(:email)
  end

  def belongs_to_franchise?
    franchise_id.present?
  end

  def has_app_image?
    image.present? || app_logo_id.present?
  end

  def money_currency
    @money_currency ||= Money::Currency.new(self.currency)
  end

  def money_delimiter
    money_currency.delimiter
  end

  def money_unit
    money_currency.symbol
  end

  def money_separator
    money_currency.separator
  end

  def ready?
    @ready ||= corporate.app_ready?
  end

  def logo_or_default_url(size = :thumb)
    logo.blank? ? "#{ self.class.name.downcase }/#{ size.to_s }.png" : logo.url(size)
  end

  def corporate
    @corporate ||= corporate? ? self : self.root
  end

  def inactive?
    !active?
  end

  def publishes_count
    @publishes_count ||= publishes.current_count_by_store
  end

  def publishes_remaining
    plan_monthly_posts.to_i - publishes_count
  end

  def can_publish_product?
    publishes_count < plan_monthly_posts.to_i
  end

  def can_update_plan?
    plan_updated_at.present? ? plan_updated_at > (DateTime.current + 30.days) : true
  end

  def trial?
    self.trial_at >= Date.current
  end

  def trial_ending?
    (trial_at - 7.days)  <= Date.current && trial?
  end

  def trial_days
    (trial_at - Date.current).to_i
  end

  def has_recurring?
    recurrings.actives.any?
  end

  def use_recurring?
    corporate.all? && corporate? || corporate.individually?
  end

  def setup_payment?
    !manual_payment? && !free_payment? && !trial? && use_recurring? && !has_recurring?
  end

  def setup_payment_option?
    !payment_option.present? && corporate?
  end

  def setup_app_image?
    if corporate?
      (image.nil? || image.new_record?) && app_logo.nil?
    else
      false
    end
  end

  def pendent_invoices?
    invoices.pendent.any?
  end

  def delayed_invoices?
    invoices.pendent.any?
  end

  def logo_or_default
    image || app_logo
  end

  def from_brazil?
    address_country == 'BR'
  end

  def current_plan_price
    if corporate?
      all? ? sum_stores_plan_price : plan_price
    else
      plan_price
    end
  end

  def current_plan_price_real
    if corporate?
      all? ? sum_stores_plan_price_real : plan_price_real
    else
      plan_price_real
    end
  end

  def sum_stores_plan_price
    Store.joins(:plan)
      .where('stores.id = :id OR stores.store_id = :id', id: id)
      .sum(:price)
  end

  def sum_stores_plan_price_real
    Store.joins(:plan)
      .where('stores.id = :id OR stores.store_id = :id', id: id)
      .sum(:price_real)
  end
end
