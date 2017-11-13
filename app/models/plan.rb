class Plan < ActiveRecord::Base
  scope :visibles, -> { where(visible: true) }
  scope :master,   -> { where(franchise_id: nil) }
  scope :actives,  -> { visibles.order('price ASC').limit(3) }
  scope :super,    -> { where(franchise_id: nil) }
  scope :visibles_or_current, ->(id) { where('visible = ? OR plans.id = ?', true, id) }

  belongs_to :franchise, touch: true

  validates :name, :price, :monthly_posts, presence: true
  validates :name, length: { maximum: 30 }
  validates :price, :price_real, :individual_price, :monthly_posts,
    numericality: true, allow_nil: true

  delegate :name, to: :franchise, prefix: true, allow_nil: true

  def name_with_price
    "#{ name } - #{ price }"
  end

  def price_by_locale
    if I18n.locale == :'pt-BR' && price_real.present?
      price_real
    else
      price
    end
  end
end
