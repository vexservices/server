class AddDefaultValueToPaidAttribute < ActiveRecord::Migration
  def change
    change_column :stores, :paid, :boolean, default: false 
  end
end
