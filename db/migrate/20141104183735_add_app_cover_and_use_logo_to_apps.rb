class AddAppCoverAndUseLogoToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_cover, :string
    add_column :apps, :use_logo, :boolean, default: false, null: false
  end
end
