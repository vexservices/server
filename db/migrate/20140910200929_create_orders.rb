class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :store, index: true

      t.date :card_expires_on
      t.decimal :value, precision: 8, scale: 2
      t.string :first_name
      t.string :last_name
      t.string :card_brand
      t.string :address
      t.string :zip
      t.string :state
      t.string :city
      t.text :log

      t.timestamps
    end
  end
end
