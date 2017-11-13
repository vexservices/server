class Device < ActiveRecord::Base
  scope :ios,        -> { where(kind: '1') }
  scope :android,    -> { where(kind: '2') }
  scope :with_token, -> { where.not(push_token: nil) }

  scope :search_by_id_or_token, ->(id) { where("token = ? OR id = ?", id.to_s, id.to_i) }

  belongs_to :store
  belongs_to :user

  has_many :messages, dependent: :delete_all

  has_and_belongs_to_many :stores

  before_create :generate_token

  def self.with_messages(store_ids)
    joins(messages: [:store])
      .select('devices.id, devices.name, devices.email, devices.phone, stores.id as store_id, stores.name as store_name')
      .select('SUM(CASE WHEN messages.read_at IS NULL AND messages.kind = 1 THEN 1 ELSE 0 END) as messages_count')
      .group('devices.id, devices.name, devices.email, devices.phone, stores.id, stores.name')
      .merge(Message.of_store(store_ids))
  end

  def friendly_name
    name || email || phone || I18n.t('labels.anonymous')
  end

  def token_with_mask
    "<%s %s %s %s %s %s %s %s>" % push_token.gsub(' ', '').scan(/([a-zA-Z0-9]{8})/).flatten
  end

  def android?
    kind == '2'
  end

  private

    def generate_token
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Device.exists?(token: random_token)
      end
    end
end
