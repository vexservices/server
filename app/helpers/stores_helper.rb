module StoresHelper
  def trial_message
    if current_store.trial_ending?
      info_message(t('messages.trial_period', days: current_store.trial_days))
    end
  end

  def store_link_message
    info_message(t('messages.branch_store_link_html', link: link_to(create_new_brach_url, create_new_brach_url, target: '_blank')))
  end

  def create_new_brach_url
    "#{root_url}/#{current_store.number}"
  end
end
