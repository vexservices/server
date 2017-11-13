class AddTestModeToApps < ActiveRecord::Migration
  def change
    add_column :apps, :test_mode, :boolean, default: false, null: false
  end
end
