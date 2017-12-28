class AddPriceToStores < ActiveRecord::Migration
  def change
    add_column :stores, :price, :decimal, precision: 8, scale: 2
  end
end
