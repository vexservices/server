class Address < ActiveRecord::Base
  belongs_to :store, touch: true
  belongs_to :seller, touch: true

  validates :street, :city, :state, :country, :zip, presence: true

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: :has_coordenates?

  def address_changed?
    street_changed? || city_changed? || state_changed? || latitude.blank? || longitude.blank?
  end

  def has_coordenates?
    longitude.present? && latitude.present?
  end

  def full_address
    "#{ street }, #{ city }, #{ state } - #{ country }"
  end
end
