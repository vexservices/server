class AddRegisterToStores < ActiveRecord::Migration
  def change
    add_column :stores, :register, :boolean
  end
end
