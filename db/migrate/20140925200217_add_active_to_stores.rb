class AddActiveToStores < ActiveRecord::Migration
  def change
    add_column :stores, :active, :boolean, default: true, null: false
  end
end
