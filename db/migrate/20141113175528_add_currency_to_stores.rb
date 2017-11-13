class AddCurrencyToStores < ActiveRecord::Migration
  def change
    add_column :stores, :currency, :string, null: false, default: "USD"
  end
end
