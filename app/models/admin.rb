class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :master_admin, -> { where(master_admin: true) }
  scope :app_admin,    -> { where(master_admin: false) }

  belongs_to :franchise
  has_many :franchises

  validates :name, presence: true

  delegate :name, to: :franchise, prefix: true, allow_nil: true

  def timeout_in
    5.hours
  end

  def belongs_to_franchise?
    franchise_id.present?
  end

  def app_stores
    @app_stores ||= Store.where(id: stores_ids)
  end
end
