class Product < ActiveRecord::Base
  include Picturable
  include Moneyable

  scope :search_by_code, ->(term) { where(code: term.to_s.upcase ) }

  belongs_to :store
  belongs_to :category

  has_many :pictures, as: :imageable
  has_many :publishes
  has_many :properties

  has_and_belongs_to_many :schedules, touch: true
  has_and_belongs_to_many :stores

  accepts_nested_attributes_for :pictures, :properties, allow_destroy: true

  validates :name, :price, presence: true
  validates :regular_price, :price, numericality: true, allow_blank: true
  validates :name, uniqueness: { scope: :store_id }

  delegate :name_with_father, :name, to: :category, prefix: true, allow_nil: true
  delegate :name, :corporate?, to: :store, prefix: true, allow_nil: true

  def published?
    self.try(:publish_id)
  end

  def publish(store, user = nil)
    unless store.publishes.current(self.id).present?
      store.publishes.create(
        product: self,
        price: self.price_by_store(store),
        regular_price: self.regular_price_by_store(store),
        user: user,
        published_until: DateTime.current + 5.years
      )
    else
      return false
    end
  end

  def unpublish(store)
    if publish = store.publishes.current(self.id)
      publish.update_attribute(:removed_at, DateTime.current)
    else
      false
    end
  end

  def product_or_price_by_store(store)
    store_id == store.id ? self : Price.where(store_id: store.id, product_id: id).first
  end

  def price_by_store(store)
    record = product_or_price_by_store(store)
    record.present? ? record.price : price
  end

  def regular_price_by_store(store)
    record = product_or_price_by_store(store)
    record.present? ? record.regular_price : regular_price
  end
  def publish_until
    publish = Publish.where({product_id: self.id}).order(:published_until).published.active.first
    if (publish)
      publish.published_until
    else
      nil
    end
  end
end
