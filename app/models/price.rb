class Price < ActiveRecord::Base
  include Moneyable

  belongs_to :store
  belongs_to :product

  validates :price, presence: true
  validates :regular_price, :price, numericality: true, allow_blank: true
end
