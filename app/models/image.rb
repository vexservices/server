require 'file_size_validator'

class Image < ActiveRecord::Base
  attr_accessor :secret, :skip_extension_with_list, :image_upload_height,
    :image_upload_width

  scope :samples, -> { where(store_id: nil) }

  scope :invalid, -> do
    where('width BETWEEN 1 AND 2047 OR height BETWEEN 1 AND 1535')
    .where.not(store_id: nil)
  end

  before_save :update_image_attributes

  belongs_to :store
  belongs_to :business

  mount_uploader :file, AppImageUploader
  process_in_background :file

  validates :file, file_size: { maximum: 10.megabytes.to_i }, presence: true

  delegate :setup_app_image?, :name, to: :store, prefix: true, allow_nil: true

  def belongs_to_corporate?
    store_id.present?
  end

  private

    def check_file_dimensions
      return if store_setup_app_image?

      if file.present? &&
        image_upload_width.to_i != 2048 &&
        image_upload_height.to_i != 1536

        message = I18n.t('errors.messages.invalid_dimensions', width: '2048', height: '1536')
        errors.add :file, message
      end
    end

    def update_image_attributes
      if file.present?
        path_or_url = file.path if Rails.env.development? || Rails.env.test?
        path_or_url ||= file.url

        self.width, self.height = FastImage.size(path_or_url)

        self.width  ||= 0
        self.height ||= 0
      end
    end
end
