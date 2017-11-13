json.categories @categories do |category|
  json.id   category.id
  json.name category.name

  json.actions do
    json.edit   policy(category).edit?
    json.delete policy(category).destroy?
  end

  json.subcategories category.categories.each do |sub|
    json.id   sub.id
    json.name sub.name

    json.actions do
      json.edit   policy(sub).edit?
      json.delete policy(sub).destroy?
    end
  end
end
