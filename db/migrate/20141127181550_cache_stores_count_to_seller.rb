class CacheStoresCountToSeller < ActiveRecord::Migration
  def up
    execute "update sellers set stores_count=(select count(*) from stores where stores.seller_id=sellers.id)"
  end

  def down
  end
end
