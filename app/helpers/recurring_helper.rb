module RecurringHelper
  def cancel_recurring_link
    link_to t('buttons.cancel_recurring'), recurring_path, method: :delete,
      class: 'btn btn-sm btn-danger', data: { confirm: t('messages.confirm.default') }
  end

  def recurring_message
    return if controller_name == 'orders' || !current_store.setup_payment?

    alert_message(
      t('messages.recurring_pendent_html',
        link: link_to(t('buttons.update_credit_card'), new_order_path, class: 'btn btn-danger')
      )
    )
  end
end
