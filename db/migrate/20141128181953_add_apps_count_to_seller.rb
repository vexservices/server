class AddAppsCountToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :apps_count, :integer, default: 0, null: false
  end
end
