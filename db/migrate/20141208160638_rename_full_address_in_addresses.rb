class RenameFullAddressInAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :full_address, :address
  end
end
