class AddStoreNameToPins < ActiveRecord::Migration
  def change
    add_column :pins, :store_name, :string
  end
end
