class PushObserver < ActiveRecord::Observer
  def after_create(push)
    corporate = push.store
    PushNotificationWorker.perform_async(corporate.id) if corporate.app.present?
  end
end
