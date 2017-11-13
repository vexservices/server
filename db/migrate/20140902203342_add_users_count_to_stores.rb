class AddUsersCountToStores < ActiveRecord::Migration
  def change
    add_column :stores, :users_count, :integer, default: 0, null: false
  end
end
