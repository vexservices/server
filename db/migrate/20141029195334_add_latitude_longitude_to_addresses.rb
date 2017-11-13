class AddLatitudeLongitudeToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float
    add_column :addresses, :full_address, :string
  end
end
