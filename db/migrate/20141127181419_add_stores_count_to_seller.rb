class AddStoresCountToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :stores_count, :integer, default: 0, null: false
  end
end
