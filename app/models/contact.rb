class Contact < ActiveRecord::Base
  belongs_to :franchise

  validates :name, :email, :message, presence: true
  validates :message, length: { maximum: 500 }
  validates :email, email: true

  delegate :name, to: :franchise, prefix: true, allow_nil: true
end
