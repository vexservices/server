class StoreCounterObserver < ActiveRecord::Observer
  observe :store

  def after_create(store)
    recount_actives_stores(store)
  end

  def after_update(store)
    if store.blocked_changed?
      recount_actives_stores(store)
    end
  end

  def after_destroy(store)
    recount_actives_stores(store)
  end

  protected

  # Recount all actives stores
  def recount_actives_stores(store)
    if corporate = store.store
      corporate.active_stores_count = corporate.stores.actives.count
      corporate.save
    end
  end
end
