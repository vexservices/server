class Recurring < ActiveRecord::Base
  scope :actives, -> { where(canceled_at: nil) }

  belongs_to :store
  has_many :logs
end
