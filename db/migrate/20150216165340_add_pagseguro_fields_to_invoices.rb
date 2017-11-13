class AddPagseguroFieldsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :status, :integer
    add_column :invoices, :transaction_id, :string
    add_column :invoices, :closed, :boolean, default: false, null: false
    add_column :invoices, :log, :text
  end
end
