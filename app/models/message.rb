class Message < ActiveRecord::Base
  scope :by_store,  ->{ where(kind: 2) }
  scope :by_device, ->{ where(kind: 1) }
  scope :unread,    ->{ where(read_at: nil) }
  scope :of_store,  ->(id){ where(store_id: id) }

  belongs_to :store
  belongs_to :device, touch: true

  validates :message, presence: true

  def self.device_unread_count
    by_device.unread.count
  end

  def by_device?
    kind == 1
  end
end
