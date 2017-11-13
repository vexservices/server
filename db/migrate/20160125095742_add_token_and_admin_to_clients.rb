class AddTokenAndAdminToClients < ActiveRecord::Migration
  def change
    add_column :clients, :token, :string
    add_column :clients, :admin, :boolean, default: false, null: false
  end
end
