json.stores @stores do |store|
  json.id             store.id
  json.name           store.name
  json.logo           store.logo.blank? ? default_image_for_logo('medium') : store.logo.url(:medium)
  json.messages_count store.messages_count
end
