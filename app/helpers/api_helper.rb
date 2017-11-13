module ApiHelper
  def messages_for_api
    messages = []

    messages << 'app_pendent'        unless current_store.ready?
    messages << 'limit_of_publishes' unless current_store.can_publish_product?
    messages << 'payment_pendent'    if current_store.setup_payment_option?
    messages << 'trial_ending'       if current_store.trial_ending?

    messages
  end

  def default_image_for_logo(size = 'medium')
    "http://assets2.vexapps.com/common/store/#{ size }.png"
  end
end
