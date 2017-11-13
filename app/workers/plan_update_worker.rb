class PlanUpdateWorker
  include Sidekiq::Worker
  
  def perform(store_id)
    corporate = Store.find(store_id)

    return unless corporate.corporate?

    corporate.stores.find_each do |store|
      if store.plan_monthly_posts < corporate.plan_monthly_posts
        store.plan = corporate.plan
        store.save!
      end
    end
  end
end