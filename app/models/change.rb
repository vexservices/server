class Change < ActiveRecord::Base
  belongs_to :changeable, polymorphic: true

  delegate :name, to: :changeable, allow_nil: true
end
