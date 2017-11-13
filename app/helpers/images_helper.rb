module ImagesHelper
  def image_helper_message
    content_tag :div, t('messages.images.help_html'), class: "note note-info"
  end

  def logo_helper_message
    content_tag :div, t('messages.images.select_logo_html'), class: "note note-info"
  end
end
