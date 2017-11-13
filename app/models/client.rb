class Client < ActiveRecord::Base
  include EncryptPassword

  belongs_to :store
  has_and_belongs_to_many :stores

  validates :name, :username, :password, presence: true
  validates :username, length: { minimum: 5 }, uniqueness: true
  validates :password, length: { minimum: 8 }
end
