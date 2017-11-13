class AddNameToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :name, :string
    add_column :devices, :email, :string
    add_column :devices, :phone, :string
  end
end
