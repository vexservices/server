json.category do
  json.id   @category.id
  json.name @category.name
  json.category_id   @category.category_id
  json.category_name @category.category_name
end

json.categories @categories do |category|
  json.id   category.id
  json.name category.name
end
