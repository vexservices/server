class ChangePriceAndRegularPriceInPins < ActiveRecord::Migration
  def change
    change_column :pins, :price, :decimal, precision: 16, scale: 2
    change_column :pins, :regular_price, :decimal, precision: 16, scale: 2
  end
end
