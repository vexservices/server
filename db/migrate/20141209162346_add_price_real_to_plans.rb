class AddPriceRealToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :price_real, :decimal, precision: 8, scale: 2
  end
end
