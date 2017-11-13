class Department < ActiveRecord::Base
  translates :title
  globalize_accessors :locales => [:en, :es, :'pt-BR'], :attributes => [:title]

  default_scope { includes(:translations).order('name ASC') }

  scope :master, ->{ where(store_id: nil) }
  scope :super,  ->{ where(store_id: nil, department_id: nil) }
  scope :sub,    ->{ where(store_id: nil).where.not(department_id: nil) }
  scope :search_by_name, ->(term) { where(name: term ) }

  belongs_to :store
  belongs_to :department

  has_many :corporates, ->{ where(corporate: true) }, class_name: 'Store'
  has_many :departments

  has_and_belongs_to_many :stores

  validates :name, presence: true, uniqueness: { scope: :store_id }
end
