class AddPaidToStores < ActiveRecord::Migration
  def change
    add_column :stores, :paid, :boolean
  end
end
