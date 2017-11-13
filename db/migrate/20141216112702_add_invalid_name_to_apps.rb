class AddInvalidNameToApps < ActiveRecord::Migration
  def change
    add_column :apps, :invalid_name, :boolean, null: false, default: false
  end
end
