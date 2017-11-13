module InvoicesHelper
  def delayed_invoices_message
    return unless current_store.delayed_invoices?

    alert_message t('messages.delayed_invoices')
  end
end
