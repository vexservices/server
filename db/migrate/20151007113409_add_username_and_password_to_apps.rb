class AddUsernameAndPasswordToApps < ActiveRecord::Migration
  def change
    add_column :apps, :username, :string
    add_column :apps, :password_hash, :string, default: ''
  end
end
