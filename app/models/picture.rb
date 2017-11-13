class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true, touch: true

  mount_uploader :file, PictureUploader

  validates :file, presence: true, file_size: { maximum: 5.megabytes.to_i }

  def product?
    imageable_type == 'Product'
  end
end
