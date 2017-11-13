class AddRegularPriceToPublishes < ActiveRecord::Migration
  def change
    add_column :publishes, :regular_price, :decimal, precision: 8, scale: 2
  end
end
