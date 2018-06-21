class AddStoreTabToStores < ActiveRecord::Migration
  def change
    add_column :stores, :store_tab, :string
    add_column :stores, :product_tab, :string
  end
end
