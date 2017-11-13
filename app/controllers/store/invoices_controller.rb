class Store::InvoicesController < Store::StoreController
  set_tab :invoices
  before_action :set_invoice, only: [:show, :payment, :finalization]

  def index
    @invoices = current_store.invoices.order(created_at: :desc).page(params[:page])
  end

  def show
    @invoice = current_store.invoices.find(params[:id])

    pdf = InvoicePdf.new(@invoice, view_context)

    send_data pdf.render, filename: "#{@invoice.number}.pdf",
                          type: "application/pdf",
                          disposition: "inline"
  end

  def payment
    pagseguro = PagSeguroGateway.new(
      @invoice,
      payment_notifications_url(invoice_id: @invoice.id),
      finalization_invoice_url(@invoice)
    )

    response = pagseguro.response

    if response.errors.any?
      redirect_to invoices_path, alert: response.errors.join("\n")
    else
      redirect_to response.url
    end
  end

  def finalization
    @invoice.update_attributes(paid_at: DateTime.now, status: StatusTypes::WAIT_PAYMENT )

    redirect_to invoices_path, notice: t('messages.payment')
  end

  private

    def set_invoice
      @invoice = current_store.invoices.find(params[:id])
    end
end
