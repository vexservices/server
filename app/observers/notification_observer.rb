class NotificationObserver < ActiveRecord::Observer
  def after_create(notification)
    SendNotificationWorker.perform_async(
      notification.store_id,
      notification.message
    )
  end
end
