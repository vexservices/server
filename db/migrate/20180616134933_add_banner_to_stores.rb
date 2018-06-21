class AddBannerToStores < ActiveRecord::Migration
  def change
    add_column :stores, :banner, :boolean
    add_column :products, :banner, :boolean
  end
end
