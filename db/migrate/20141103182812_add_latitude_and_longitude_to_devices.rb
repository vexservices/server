class AddLatitudeAndLongitudeToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :latitude, :float
    add_column :devices, :longitude, :float
    add_column :devices, :radius, :float
    add_column :devices, :locale, :string
  end
end
