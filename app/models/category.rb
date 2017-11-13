class Category < ActiveRecord::Base
  scope :master, lambda { where(category_id: nil) }
  scope :by_admin, lambda { where(store_id: nil) }
  scope :search_by_name, ->(term) { where('UPPER(name) like ?', "%#{ term.upcase }%") }

  belongs_to :category, touch: true
  belongs_to :store
  has_many :categories, dependent: :delete_all
  has_many :products

  validates :name, presence: true

  delegate :name, to: :category, prefix: true, allow_nil: true

  def father?
    category_id.blank?
  end

  def name_with_father
    father? ? name : "#{ category_name } > #{ name }"
  end
end
