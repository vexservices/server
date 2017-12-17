class AddDefaultValueToSearchAttribute < ActiveRecord::Migration
  def change
    change_column :stores, :search, :boolean, default: true
  end
end
