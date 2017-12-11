class AddShortNameToStores < ActiveRecord::Migration
  def change
    add_column :stores, :short_name, :string
  end
end
