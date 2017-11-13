class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :store, index: true
      t.string :name
      t.references :category, index: true
      t.text :description
      t.text :contact_info
      t.decimal :regular_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
