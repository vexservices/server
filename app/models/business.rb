class Business < ActiveRecord::Base
  translates :name
  globalize_accessors :locales => [:en, :es, :'pt-BR'], :attributes => [:name]

  has_many :images, dependent: :delete_all
  has_many :stores

  validates :name, presence: true
end
