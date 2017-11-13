class User < ActiveRecord::Base
  has_paper_trail
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  belongs_to :store, counter_cache: true
  has_many :devices, dependent: :delete_all

  validates :name, presence: true

  delegate :corporate?, :name, :store_id, to: :store, prefix: true

  def timeout_in
    5.hours
  end

  protected
    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup

      if email = conditions.delete(:email)
        where(conditions)
          .where(["lower(email) = :value AND stores.active = :status AND stores.blocked <> :status AND users.blocked <> :status",
               { value: email.downcase, status: true }])
          .from('users')
          .joins('INNER JOIN stores ON stores.id = users.store_id')
          .first
      else
        where(conditions).first
      end
    end
end
