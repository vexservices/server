json.messages @messages do |message|
  json.id         message.id
  json.message    message.message
  json.kind       message.kind
  json.read_at    message.read_at
  json.created_at message.created_at
end
