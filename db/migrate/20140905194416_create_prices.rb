class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :store, index: true
      t.references :product, index: true
      t.decimal :regular_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
