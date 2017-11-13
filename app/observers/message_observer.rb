class MessageObserver < ActiveRecord::Observer

  def after_create(message)
    PushMessageWorker.perform_async(message.device_id)
  end
end
