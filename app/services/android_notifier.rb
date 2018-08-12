class AndroidNotifier
  def self.send_push(key, tokens, options = {})
    options.reverse_merge!(title: 'Virtual Exchange', message: 'New Product')
    push_token = { 'data' => options.stringify_keys }

    gcm = GCM.new(key)
    response = gcm.send_notification(tokens, push_token)
    Rails.logger.info "reponse: #{response.to_json}"
  end
end
