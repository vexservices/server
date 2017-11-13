class SendNotification
  attr_reader :app, :corporate, :message, :store

  def initialize(store, message)
    @store = store
    @corporate = store.corporate
    @app = corporate.app
    @message = message
  end

  def send
    send_notification_to_android
    send_notification_to_ios
  end

  private

  def android_tokens
    @android_tokens ||= Device.android
                               .joins(:stores)
                               .where('stores.id = ?', store.id)
                               .pluck(:push_token)
  end

  def ios_tokens
    @ios_tokens ||= Device.ios
                           .joins(:stores)
                           .where('stores.id = ?', store.id)
                           .pluck(:push_token)
  end

  def send_notification_to_android
    return unless app.has_google_api_key?

    AndroidNotifier.send_push(
      app.google_api_key,
      android_tokens,
      title: app.name,
      message: message,
      store_id: store.id
    )
  end

  def send_notification_to_ios
    return unless app.has_apple_certificate?

    if Rails.env.production? || Rails.env.staging?
      path_or_url = app.apple_certificate.url
    end

    path_or_url ||= app.apple_certificate.path

    ios_tokens.each do |token|
      IosNotifier.send_push(
        path_or_url, token, message: message, store_id: store.id)
    end
  end
end
