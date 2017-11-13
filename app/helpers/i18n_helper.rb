module I18nHelper
  def translate_locale(locale)
    case locale
      when 'en' then 'English'
      when 'es' then 'Español'
      else 'Português'
    end
  end

  def translate_attribute(model, attribute)
    default = model.human_attribute_name(attribute)

    if current_corporate && current_corporate.business_key
     I18n.t(
       "active_record.attributes.#{ current_corporate.business_key }.#{ model.model_name.singular }.#{ attribute }",
       default: default
     )
    else
     default
    end
  end
  alias_method :ta, :translate_attribute

  def human_name_pluralized(model)
    default = I18n.t("active_record.models.#{model.model_name.singular}.other")

    if current_corporate && current_corporate.business_key
     I18n.t(
        "active_record.models.#{ current_corporate.business_key }.#{ model.model_name.singular }.other",
        default: default
      )
    else
       default
    end
  end
  alias_method :hnp, :human_name_pluralized

  def human_name(model)
    default = model.model_name.human

    if current_corporate && current_corporate.business_key
      I18n.t(
        "active_record.models.#{ current_corporate.business_key }.#{ model.model_name.singular }.one",
        default: default
       )
     else
      default
     end
  end
  alias_method :hn, :human_name
end
