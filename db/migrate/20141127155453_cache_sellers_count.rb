class CacheSellersCount < ActiveRecord::Migration
  def up
    execute "update sellers set sellers_count=(select count(*) from sellers s where s.seller_id=sellers.id)"
  end

  def down
  end
end
