class Property < ActiveRecord::Base
  belongs_to :product

  validates :name, :value, presence: true
end
