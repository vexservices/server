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
json.created_at     @product.created_at

json.images @product.pictures.each do |picture|
  json.id       picture.id
  json.thumb    picture.file.url(:thumb)
  json.medium   picture.file.url(:medium)
  json.original picture.file.url(:original)
end

json.actions do
  json.edit        policy(@product).edit?
  json.delete      policy(@product).destroy?
  json.featured    false
  json.publish     false
  json.unpublish   false
  json.post_all    false
  json.unpost_all  false
end
