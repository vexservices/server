class PublishObserver < ActiveRecord::Observer
  def after_create(publish)
    return unless publish.store.present?

    if corporate = publish.store.corporate
      unless Push.today.search_by_store(corporate.id).any?
        Push.create(store_id: corporate.id)
      end
    end
  end
end
