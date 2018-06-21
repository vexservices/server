json.product do
  json.id             @product.id
  json.code           @product.code
  json.name           @product.name
  json.regular_price  number_to_currency_by_store_currency @product.regular_price
  json.price          number_to_currency_by_store_currency @product.price
  json.description    simple_format(@product.description)
  json.contact_info   simple_format(@product.contact_info)
  json.category_name  @product.category_name
  json.category_id    @product.category_id
  json.payment_option @product.payment_option
  json.banner         @product.banner
end

json.categories @categories do |category|
  json.id   category.id
  json.name category.name

  json.subcategories category.categories.each do |sub|
    json.id   sub.id
    json.name sub.name
  end
end
