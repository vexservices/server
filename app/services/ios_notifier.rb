class IosNotifier
  def self.send_push(certificate, token, options = {})

    message = options.fetch(:message, 'New Product.')
    apn = Houston::Client.production

    notification = Houston::Notification.new(device: token.ios_token)
    notification.alert = message
    notification.badge = 1
    notification.sound = "sosumi.aiff"

    if options
      notification.custom_data = options
    end

    if Rails.env.production? || Rails.env.staging?
      temp_file = Tempfile.new('certificate')

      File.open(temp_file.path, "wb") do |f|
        f.write HTTParty.get(certificate).parsed_response
      end

      apn.certificate = File.read(temp_file.path)
    else
      apn.certificate = File.read(certificate)
    end

    apn.push(notification)
  end

  def self.mask_token(token)
    "<%s %s %s %s %s %s %s %s>" % token.gsub(' ', '').scan(/([a-zA-Z0-9]{8})/).flatten
  rescue
    token
  end
end
