class SendNotificationWorker
  include Sidekiq::Worker

  def perform(store_id, message)
    store = Store.find(store_id)

    SendNotification.new(store, message).send
  end
end
