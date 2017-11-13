class PaymentNotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    invoice = Invoice.find(params[:id])

    transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

    if transaction.errors.empty?
      invoice.update_attributes(
        transaction_id: transaction.code,
        status:  invoice.status_by_pagseguro(transaction.status),
        closed: true,
        log: transaction.inspect
      )
    end

    render nothing: true, status: 200
  end
end
