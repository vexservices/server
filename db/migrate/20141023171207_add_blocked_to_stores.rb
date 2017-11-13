class AddBlockedToStores < ActiveRecord::Migration
  def change
    add_column :stores, :blocked, :boolean, default: false, null: false
  end
end
