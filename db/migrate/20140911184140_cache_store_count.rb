class CacheStoreCount < ActiveRecord::Migration
  def change
    execute "update stores set stores_count = (select count(*) from stores b where b.store_id = stores.id)"
  end
end
