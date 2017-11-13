class PagSeguroGateway
  attr_accessor :invoice, :notification_url, :redirect_url

  def initialize(invoice, notification_url, redirect_url)
    @invoice = invoice
    @notification_url = notification_url
    @redirect_url = redirect_url

    setup
  end

  def routes
    Rails.application.routes.url_helpers
  end

  def setup
    PagSeguro.email ||= Rails.application.secrets.pagseguro_email
    PagSeguro.token ||= Rails.application.secrets.pagseguro_token

    PagSeguro.environment = Rails.env.production? ? 'production' : 'sandbox'

    @payment = PagSeguro::PaymentRequest.new
    @payment.reference = @invoice.id

    @payment.notification_url = notification_url
    @payment.redirect_url     = redirect_url

    @payment.items << {
      id: @invoice.number,
      description: @invoice.plan_name,
      amount: @invoice.value_real,
      quantity: 1
    }
  end

  def response
    @payment.register
  end
end
