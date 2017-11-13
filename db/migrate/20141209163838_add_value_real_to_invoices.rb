class AddValueRealToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :value_real, :decimal, precision: 8, scale: 2
  end
end
