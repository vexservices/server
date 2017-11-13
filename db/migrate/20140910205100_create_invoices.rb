class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :store, index: true
      t.string :number
      t.string :plan_name
      t.decimal :value, precision: 8, scale: 2
      t.datetime :paid_at

      t.timestamps
    end
  end
end
