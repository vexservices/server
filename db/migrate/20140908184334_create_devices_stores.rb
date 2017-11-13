class CreateDevicesStores < ActiveRecord::Migration
  def change
    create_table :devices_stores do |t|
      t.references :device, index: true
      t.references :store, index: true
    end
  end
end
