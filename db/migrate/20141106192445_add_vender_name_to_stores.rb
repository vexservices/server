class AddVenderNameToStores < ActiveRecord::Migration
  def change
    add_column :stores, :vender_name, :string
  end
end
