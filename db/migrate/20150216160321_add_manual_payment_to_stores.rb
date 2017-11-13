class AddManualPaymentToStores < ActiveRecord::Migration
  def change
    add_column :stores, :manual_payment, :boolean, default: false, null: false
  end
end
