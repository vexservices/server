json.id        @store.id
json.name      @store.name
json.corporate @store.corporate?
json.logo      @store.logo.blank? ? default_image_for_logo('medium') : @store.logo.url(:medium)
