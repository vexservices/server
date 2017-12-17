class AddColumnSearchToStores < ActiveRecord::Migration
  def change
    add_column :stores, :search, :boolean
  end
end
