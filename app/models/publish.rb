class Publish < ActiveRecord::Base
  scope :published,    -> { where(removed_at: nil) }
  scope :active,       -> { where('published_until >= ?', DateTime.current) }
  scope :to_check,     -> { where('published_until between ? AND ?', DateTime.current - 1.hour, DateTime.current) }
  scope :by_corporate, -> { where(published_by_corporate: true) }
  scope :by_store,     -> { where(published_by_corporate: false) }
  scope :featured,     -> { where(featured: true) }

  scope :search_product, ->(id) { where(product_id: id) }
  scope :by_date,        ->(initial, final) { where('DATE(created_at) between ? AND ?', initial, final) }

  belongs_to :store, touch: true
  belongs_to :product, touch: true
  belongs_to :user

  delegate :image, :category_name, :name, to: :product, prefix: true,
    allow_nil: true

  def self.desmark_all
    active.featured.update_all(featured: false)
  end

  def self.current(product_id)
    search_product(product_id).active.published.first
  end

  def self.by_product(product_id)
    search_product(product_id).active.published
  end

  def self.search_active
    active.published.by_corporate
  end

  def self.current_count
    where('DATE(created_at) BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
    .count
  end

  def self.current_count_by_store
    where('DATE(created_at) BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
    .by_store
    .count
  end

  def feature(level = 1)
    self.update_attribute(:feature_level, level)
  end

  def featured
    !feature_level.zero?
  end
end
