class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.references :store, index: true
      t.references :device, index: true
      t.references :publish, index: true
      t.references :product, index: true

      t.string :name
      t.string :category_name
      t.text :description
      t.text :contact_info
      t.decimal :regular_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
