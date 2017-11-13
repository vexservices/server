if @device
  json.device do
    json.id   @device.id
    json.name @device.name
    json.logo @device.phone
    json.logo @device.email
  end

  json.messages @messages do |message|
    json.id         message.id
    json.message    message.message
    json.kind       message.kind
    json.read_at    message.read_at
    json.created_at message.created_at
  end
else
  json.devices @devices do |device|
    json.id             device.id
    json.name           device.name
    json.email          device.email
    json.phone          device.phone
    json.messages_count device.messages_count
  end
end
