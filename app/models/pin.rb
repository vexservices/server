class Pin < ActiveRecord::Base
  has_many :pictures, as: :imageable, dependent: :delete_all
end
