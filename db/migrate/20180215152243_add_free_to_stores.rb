class AddFreeToStores < ActiveRecord::Migration
  def change
    add_column :stores, :free, :boolean, default: false
  end
end
