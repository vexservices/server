class ChangePriceAndRegularPriceInPublishes < ActiveRecord::Migration
  def change
    change_column :publishes, :price, :decimal, precision: 16, scale: 2
    change_column :publishes, :regular_price, :decimal, precision: 16, scale: 2
  end
end
