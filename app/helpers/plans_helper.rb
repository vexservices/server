module PlansHelper
  def plan_item(bool, text)
    content_tag :li, class: bool ? nil : 'disabled' do
      html = fa_icon("#{ bool ? 'check' : 'times' }")
      html += " #{ text }"
      html.html_safe
    end
  end

  def plans_messages
    content_tag :div, t('messages.plan.change_limit_html'), class: "note note-danger"
  end

  def plan_check_icon(bool)
    fa_icon("#{ bool ? 'check' : 'times' }")
  end
end
