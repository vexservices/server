class ChangePriceAndRegularPriceInPrices < ActiveRecord::Migration
  def change
    change_column :prices, :price, :decimal, precision: 16, scale: 2
    change_column :prices, :regular_price, :decimal, precision: 16, scale: 2
  end
end
