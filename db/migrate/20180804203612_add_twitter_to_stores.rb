class AddTwitterToStores < ActiveRecord::Migration
  def change
    add_column :stores, :twitter, :string
  end
end
