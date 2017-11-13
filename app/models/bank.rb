class Bank < ActiveRecord::Base
  belongs_to :seller

  validates :name, :agency, :number, presence: true
end
