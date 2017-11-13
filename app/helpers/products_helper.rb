module ProductsHelper
  def product_seals(product)
    imgs = ''

    imgs += image_tag("published-#{I18n.locale}.png", class: 'img-published') if policy(product).unpublish?
    imgs += image_tag("featured-#{ product.try(:publish_feature_level) }.png", class: 'img-featured') if policy(product).unfeature?

    imgs.html_safe
  end

  def publishes_remaining_messages
    if current_store.publishes_remaining <= 0
      link = link_to(t('buttons.upgrade_plan'), plan_path)

      alert_message t('messages.publish_ending_html', total: 0, link: link)
    elsif current_store.publishes_remaining <= 30
      info_message t('messages.publish_ending_html', total: current_store.publishes_remaining, link: nil)
    end
  end

  def store_product_label(product, store)
    if product.store_id != store.id
      content_tag :span, product.store_name, class: 'label label-info'
    end
  end

  def limit_of_publishes_message
    alert_message(t('messages.limit_of_publishes')) unless current_store.can_publish_product?
  end

  def link_to_schedule(product, html_options = {})
    params = { product_ids: [product.id] }

    html_options.reverse_merge!(class:'btn btn-sm btn-info', method: :get, remote: true)

    link_to t('buttons.schedule'), new_schedule_path(params), html_options
  end
end
