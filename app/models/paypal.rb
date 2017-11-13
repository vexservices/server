class Paypal < ActiveRecord::Base
  belongs_to :franchise

  scope :master, -> { where(franchise_id: nil) }
  scope :search_by_country, ->(term) { where(country: term) }

  validates :login, :password, :partner, :country, presence: true

  delegate :name, to: :franchise, prefix: true, allow_nil: true
end
