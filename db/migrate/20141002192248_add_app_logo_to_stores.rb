class AddAppLogoToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :app_logo, index: true
  end
end
