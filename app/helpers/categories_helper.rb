module CategoriesHelper
  def options_for_categories(categories)
    categories.map do |category|
      [[category.name, category.id, data: { class: 'master' }]] |

      category.categories.map do |sub|
        [sub.name, sub.id, data: { class: 'sub' }]
      end
    end.flatten(1)
  end

  def categories_messages
    content_tag :div, t('messages.category.publish'), class: "note note-warning"
  end
end
