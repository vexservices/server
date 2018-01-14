json.cache! [cache_for_stores_three(@stores), @client.try(:cache_key)], expires_in: 24.hours do
  json.array! @stores do |store|
    json.cache! ['tree', store, @client.try(:cache_key)], expires_in: 24.hours do
      json.id     store.id
      json.parent store.parent_id || '#'
      json.text   store.short_name
      json.icon   'fa fa-bank'
      json.state do
        json.opened  store.depth < 3 ? true : false
        json.selected @client ?  @client.store_ids.include?(store.id) : false
      end
    end
  end
end
