class AddActivesStoresCountToStores < ActiveRecord::Migration
  def change
    add_column :stores, :active_stores_count, :integer, null: false, default: 0
  end
end
