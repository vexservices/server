class PushMessageWorker
  include Sidekiq::Worker
  #sidekiq_options queue: "push notification"

  def perform(device_id)
    device = Device.find(device_id)
    app    = device.store.app

    if device.android?
      send_android_notification(app, device)
    else
      send_ios_notification(app, device)
    end
  end

  private

  def send_android_notification(app, device)
    return unless app.has_google_api_key?

    AndroidNotifier.send_push(
      app.google_api_key,
      [device.push_token],
      title: app.name,
      message: 'You have new message.'
    )
  end

  def send_ios_notification(app, device)
    return unless app.has_apple_certificate?

    if Rails.env.production? || Rails.env.staging?
      path_or_url = app.apple_certificate.url
    end

    path_or_url ||= app.apple_certificate.path

    IosNotifier.send_push(path_or_url, device.push_token, message: 'You have new message.')
  end
end
