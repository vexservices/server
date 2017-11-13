class Franchise < ActiveRecord::Base
  mount_uploader :logo, FranchiseLogoUploader

  belongs_to :admin

  has_many :admins
  has_many :plans
  has_many :sellers
  has_many :stores
  has_many :banners
  has_many :contacts
  has_many :paypals
  has_many :videos

  validates :name, :subdomain, :domain, :trial_period, presence: true
  validates :email, email: true, allow_blank: true
  validates :name, :subdomain, uniqueness: true
  validates :subdomain, exclusion: { in: %w(www http https api) }, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :logo, file_size: { maximum: 0.5.megabytes.to_i }
  validates :trial_period, numericality: { only_integer: true }

  accepts_nested_attributes_for :admins

  delegate :name, to: :admin, prefix: true, allow_nil: true

  def has_trial_period?
    trial_period.to_i > 0
  end
end
