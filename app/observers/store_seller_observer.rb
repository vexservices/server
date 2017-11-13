class StoreSellerObserver < ActiveRecord::Observer
  observe :store

  def after_create(store)
    if store.seller_id.present?
      SellerAppCountWorker.perform_at(1.minutes.from_now, store.seller.id)
    end
  end

  def after_update(store)
    if store.seller_id_changed? && store.corporate?
      reset_seller_counters(store)
    end
  end

  protected

  # Reset counters in seller when change the seller of store
  def reset_seller_counters(store)
    # Reset counter cache to new seller
    Seller.reset_counters(store.seller_id, :stores)
    # Recount all stores_count for all sellers tree
    SellerAppCountWorker.perform_at(1.minutes.from_now, store.seller.id)

    if store.seller_id_was && Seller.exists?(store.seller_id_was)
      # Reset counter cache to old seller
      Seller.reset_counters(store.seller_id_was, :stores)
      # Recount all stores_count for all sellers tree
      SellerAppCountWorker.perform_at(1.minutes.from_now, store.seller_id_was)
    end
  end
end
