class AndroidNotifier
  def self.send_push(key, tokens, options = {})
    options.reverse_merge!(title: 'Virtual Exchange', message: 'New Product')
    push_token = { 'data' => options.stringify_keys }

    fcm_options = {
      notification: {
        title: options[:title],
        body: options[:message]
      },
      data: {
        store_id: options[:store_id]
      }
    }
    fcm = FCM.new(key)
    response = fcm.send_notification(tokens, fcm_options)
  end
end
