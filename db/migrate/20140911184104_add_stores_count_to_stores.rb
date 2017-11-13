class AddStoresCountToStores < ActiveRecord::Migration
  def change
    add_column :stores, :stores_count, :integer, default: 0, null: false
  end
end
