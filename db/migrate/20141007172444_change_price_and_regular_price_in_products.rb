class ChangePriceAndRegularPriceInProducts < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, precision: 16, scale: 2
    change_column :products, :regular_price, :decimal, precision: 16, scale: 2
  end
end
