class Seller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable, :timeoutable

  default_scope { order('created_at DESC') }

  scope :search_by_number, ->(number) { where(number: number.to_s.upcase) }
  scope :master, ->{ where(seller_id: nil) }
  scope :super,  ->{ where(franchise_id: nil) }

  belongs_to :seller, counter_cache: true
  belongs_to :franchise

  has_one :address
  has_one :bank

  has_many :stores
  has_many :sellers

  validates :name, :phone, :commission, :email, presence: true
  validate :limit_of_commission, unless: :master?

  before_create :set_number

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :bank, reject_if: proc { |attributes| attributes['name'].blank? }

  delegate :state, :city, :street, :zip, :country,
    to: :address, prefix: true, allow_nil: true

  delegate :name, :brazil?, to: :seller, prefix: true, allow_nil: true
  delegate :name, to: :franchise, prefix: true, allow_nil: true

  def timeout_in
    5.hours
  end

  def belongs_to_franchise?
    franchise_id.present?
  end

  def master?
    seller_id.blank?
  end

  def brazil?
    address_country == 'BR'
  end

  def is_brazilian?
    brazil? || seller_brazil?
  end

  def name_with_number
    "#{ number } - #{ name }"
  end

  private

    def limit_of_commission
      if master = self.seller
        if self.commission && master.commission.to_f < self.commission
          errors.add :commission, I18n.t('errors.messages.less_than_or_equal_to', count: master.commission)
        end
      end
    end

    def set_number
      self.number = loop do
        random_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..5].upcase
        break random_number unless Seller.exists?(number: random_number)
      end
    end
end
