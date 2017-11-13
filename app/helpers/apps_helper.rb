module AppsHelper
  def link_to_skip_app_cover(app, html_options = {})
    params = { :app => { use_logo: true } }
    html_options.reverse_merge!(class:'btn btn-success', method: "put")

    link_to t('buttos.skip_step'), app_path(params), html_options
  end

  def app_cover_helper_message
    content_tag :div, t('messages.app_cover.help'), class: "note note-info"
  end
end
