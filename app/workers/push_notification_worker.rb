class PushNotificationWorker
  include Sidekiq::Worker
  #sidekiq_options queue: "push notification"

  def perform(store_id, message = nil)
    store = Store.find(store_id).corporate
    app   = store.app

    if app.has_google_api_key?
      android_devices = store.devices.with_token.android

      AndroidNotifier.send_push(
        app.google_api_key,
        android_devices.map(&:push_token),
        title: app.name,
        message: message
      )
    end

    if app.has_apple_certificate?
      ios_devices = store.devices.with_token.ios

      ios_devices.each do |device|
        if Rails.env.production? || Rails.env.staging?
          path_or_url = app.apple_certificate.url
        end

        path_or_url ||= app.apple_certificate.path

        IosNotifier.send_push(
          path_or_url,
          device.push_token,
          message: message
        )
      end
    end
  end
end
