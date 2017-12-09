class AddDefaultValueToRegisterAttribute < ActiveRecord::Migration
  def change
    change_column :stores, :register, :boolean, default: false
  end
end
