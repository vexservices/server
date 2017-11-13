class Banner < ActiveRecord::Base
  belongs_to :franchise, touch: true

  scope :master, -> { where(franchise_id: nil) }

  mount_uploader :image, BannerUploader

  validates :image, :locale, presence: true
  validates :image, file_size: { maximum: 0.4.megabytes.to_i }

  delegate :name, to: :franchise, prefix: true, allow_nil: true
end
