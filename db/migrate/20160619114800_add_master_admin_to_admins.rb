class AddMasterAdminToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :master_admin, :boolean, default: false, null: false
    add_column :admins, :stores_ids, :integer, array: true, default: []
  end
end
