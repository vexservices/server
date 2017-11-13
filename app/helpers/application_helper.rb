module ApplicationHelper
  def datepicker_locale_file
    case I18n.locale.to_s
    when 'en'    then "datepicker/en"
    when 'pt-BR' then "datepicker/pt-br"
    when 'es'    then "datepicker/es"
    else nil end
  end

  # Franchise Path
  def admin_franchise_root_path
    current_franchise ? admin_root_url(domain: current_franchise.domain) : admin_root_url
  end

  def franchise_root_path
    current_franchise ? root_url(domain: current_franchise.domain) : root_url
  end

  # Messages
  def flash_message
    flash.collect do |key, msg|
      next if key == 'timedout'

      content_tag :div, id: key, class: "alert alert-#{key == 'notice' ? "success" : "danger"}" do
        "<a class='close' data-dismiss='alert'>×</a> #{msg}".html_safe
      end
    end.join.html_safe
  end

  def alert_message(msg)
    content_tag :div, msg, class: "alert alert-danger"
  end

  def info_message(msg)
    content_tag :div, msg, class: "alert alert-info"
  end

  def app_pendent_message
    info_message t('messages.app_pendent') unless current_store.ready?
  end

  # Create Menu Tab
  def tab_item(title, icon)
    "#{ fa_icon(icon) } #{ content_tag :span, title, class: 'mm-text' }".html_safe
  end

  def tabs_for(name, link)
    content_tag :li, link_to(name, link), class: link == request.path ? 'active' : ''
  end

  # Create Font Awesome Icons
  #
  # ex: <i class='fa fa-ok'></i>
  #
  def fa_icon(icon)
    content_tag :i, nil, class: "fa fa-#{icon}"
  end

  # Build bootstrap pane
  def pane(title, &block)
    render :layout => "shared/panel", locals: {title: title}, &block
  end

  # Display de block when object is present
  def display_when_present(collection, &block)
    msg = t('messages.empty')

    collection.present? ? capture(&block)  : "<div class='empty txt-center'>#{msg}</div>".html_safe
  end

  def boolean_span(bool)
    content_tag :p, t(bool.to_s), class: "label label-#{ bool ? 'success' : 'warning' }"
  end

  # Links
  def link_to_new(model, url, html_options = {})
    html_options.reverse_merge!(class: 'btn btn-primary btn-labeled', style: 'width: 100%;')

    link_to url, html_options do
      "<span class='btn-label icon fa fa-plus'></span> #{ t('buttons.new', model: hn(model)) }".html_safe
    end
  end

  def link_with_icon(title, url, html_options = {})
    html_options.reverse_merge!(class: 'btn btn-primary btn-labeled', style: 'width: 100%;')
    icon = html_options.delete(:icon) || 'plus'

    link_to url, html_options do
      "<span class='btn-label icon fa fa-#{icon}'></span> #{ title }".html_safe
    end
  end

  def link_to_back(url = :back, html_options={})
    html_options.reverse_merge!(class: 'btn btn-default')
    link_to t('buttons.back'), url, html_options
  end

  def link_to_destroy(url, html_options={})
    html_options.reverse_merge!(
      data: { confirm: t('messages.confirm.default') },
      method: :delete,
      class: 'btn btn-sm btn-danger',
      title: 'delete'
    )

    link_to url, html_options do
      fa_icon('trash-o').html_safe
    end
  end

  def link_to_edit(url, html_options={})
    html_options.reverse_merge!(class: 'btn btn-sm btn-default', title: 'edit')

    link_to url, html_options do
      fa_icon('pencil').html_safe
    end
  end

  def link_to_show(url, html_options={})
    html_options.reverse_merge!(class: 'btn btn-sm btn-default', title: 'show')

    link_to url, html_options do
      fa_icon('list').html_safe
    end
  end

  def field_detail(translation, value)
    html = content_tag :strong, "#{ translation }: "
    html += content_tag :span, value
    html.html_safe
  end

  def filename(path)
    File.basename(path) if path
  end
end
