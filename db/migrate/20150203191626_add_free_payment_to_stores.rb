class AddFreePaymentToStores < ActiveRecord::Migration
  def change
    add_column :stores, :free_payment, :boolean, default: false, null: false
  end
end
