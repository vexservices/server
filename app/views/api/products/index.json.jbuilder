json.messages messages_for_api

json.pagination do
  json.pages         @products.total_pages
  json.current_page  params[:page] || 1
  json.total_entries @products.total_count
end

json.products @products do |product|
  json.id             product.id
  json.name           product.name
  json.category_name  product.category_name
  json.category_id    product.category_id
  json.banner         product.banner
  json.regular_price  number_to_currency_by_store_currency(product.regular_price_by_store(current_store))
  json.price          number_to_currency_by_store_currency(product.price_by_store(current_store))
  json.image          asset_url(product.image)
  json.corporate      product.store_id != current_store.id
  json.publish_id     product.try(:publish_id)

  json.actions do
    json.featured    policy(product).unfeature?
    json.edit        policy(product).edit?
    json.delete      policy(product).destroy?
    json.publish     policy(product).publish?
    json.unpublish   policy(product).unpublish?
    json.post_all    policy(product).publish_all?
    json.unpost_all  policy(product).unpublish_all?
  end
end
