class AddFieldsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :apple_certificate, :string
    add_column :apps, :apple_store_url, :string
    add_column :apps, :google_play_url, :string
    add_column :apps, :google_api_key, :string
  end
end
