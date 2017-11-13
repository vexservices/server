class Push < ActiveRecord::Base
  scope :today, -> { where('DATE(created_at) = ?', Date.current) }
  scope :search_by_store, ->(id) { where(store_id: id) }

  belongs_to :store
end