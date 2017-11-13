class StoreObserver < ActiveRecord::Observer
  def before_create(store)
    if store.corporate?
      generate_key(store)
    else
      setup_branch_store(store)
    end

    generate_number(store)

    store.parent = store.store
    trial_period = store.franchise_trial_period || 30
    store.trial_at = Date.current + trial_period.days
  end

  def after_update(store)
    return unless store.corporate?

    if store.plan_id_changed? && store.admin_update
      PlanUpdateWorker.perform_at(5.minutes.from_now, store.id)
    end

    if store.blocked_changed?
      Store.where(store_id: store.root.subtree_ids).update_all(blocked: store.blocked)
    end

    if store.trial_at_changed?
      Store.where(store_id: store.root.subtree_ids).update_all(trial_at: store.trial_at)
    end
  end

  def before_destroy(store)
    if corporate = store.root
      store.categories.update_all(store_id: corporate.id)
    end
  end

  protected

  # Generate API key from store
  def generate_key(store)
    store.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Store.exists?(token: random_token)
    end
  end

  # Copy settings from corporate to store
  def setup_branch_store(store)
    corporate = store.store

    store.plan_id      = corporate.plan_id
    store.currency     = corporate.currency
    store.franchise_id = corporate.franchise_id
  end

  # Generate number to store
  def generate_number(store)
    store.number = loop do
      random_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..5].upcase
      break random_number unless Store.exists?(number: random_number)
    end
  end
end
