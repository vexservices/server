module JobsHelper

  def link_to_retry(url, html_options={})
    html_options.reverse_merge!(
      class: 'btn btn-sm btn-default',
      title: 'retry',
      data: { confirm: t('messages.confirm.default') },
    )

    link_to url, html_options do
      fa_icon('refresh').html_safe
    end
  end
end
