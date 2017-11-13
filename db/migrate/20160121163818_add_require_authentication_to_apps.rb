class AddRequireAuthenticationToApps < ActiveRecord::Migration
  def change
    add_column :apps, :require_authentication, :boolean, default: false, null: false
  end
end
