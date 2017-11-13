class App < ActiveRecord::Base
  include EncryptPassword

  attr_accessor :skip_observer, :image_upload_height,
    :image_upload_width

  scope :without_store, ->{ where(store_id: nil) }
  scope :with_store,    ->{ where.not(store_id: nil) }
  scope :android,       ->{ where.not(google_api_key: nil) }
  scope :ios,           ->{ where.not(apple_certificate: nil) }

  belongs_to :store

  validates :name, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z0-9 ]+\z/ },
    length: { in: 3..35 }

  validates :name, uniqueness: true

  validates :app_cover, file_size: { maximum: 5.megabytes.to_i }, allow_nil: true

  mount_uploader :apple_certificate, CertificateUploader
  mount_uploader :app_cover, AppCoverUploader

  delegate :has_app_image?, :address, :name, to: :store, prefix: true, allow_nil: true

  def self.pendent
    sql = %Q(
      apple_certificate IS NULL OR apple_certificate = ''
      OR google_api_key IS NULL OR google_api_key = ''
      OR invalid_name = ?
    )

    where(sql, true)
  end

  def authenticate?
    require_authentication?
  end

  def google_api_key_short
    google_api_key ? "#{ google_api_key[0..20] }..." : nil
  end

  def ready?
    has_google_api_key? || has_apple_certificate?
  end

  def has_google_api_key?
    google_api_key.present?
  end

  def has_apple_certificate?
    apple_certificate.present?
  end

  def language
    store_address.country
  end

  def setup_cover?
    !use_logo? && app_cover.blank?
  end

  private

    def check_file_dimensions
      if app_cover_changed? &&
        app_cover.present? &&
        image_upload_width.to_i != 2048 &&
        image_upload_height.to_i != 1536

        message = I18n.t('errors.messages.invalid_dimensions', width: '2048', height: '1536')
        errors.add(:app_cover, message)
      end
    end
end
