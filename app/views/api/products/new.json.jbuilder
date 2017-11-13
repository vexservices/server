json.categories @categories do |category|
  json.id   category.id
  json.name category.name

  json.subcategories category.categories.each do |sub|
    json.id   sub.id
    json.name sub.name
  end
end
