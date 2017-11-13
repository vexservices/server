json.id     @schedule.id
json.initial @schedule.initial
json.final  @schedule.final
json.run_at @schedule.run_at
json.products_count @schedule.products_count

json.products @schedule.products do |product|
  json.id             product.id
  json.name           product.name
  json.category_name  product.category_name
  json.regular_price  number_to_currency_by_store_currency(product.regular_price_by_store(current_store))
  json.price          number_to_currency_by_store_currency(product.price_by_store(current_store))
  json.image          asset_url(product.image)
end
