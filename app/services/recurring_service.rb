class RecurringService
  attr_accessor :recurring, :store, :gateway

  def initialize(recurring)
    @recurring = recurring
    @store     = recurring.store

    setup
  end

  def paypal
    @paypal ||= Paypal.where(country: store.address_country).first
    @paypal ||= Paypal.where(country: 'US').first
  end

  def setup
    ActiveMerchant::Billing::Base.mode = paypal.sandbox? ? :test : :production

    @gateway = ActiveMerchant::Billing::PayflowGateway.new(
      login:    paypal.login,
      password: paypal.password,
      partner:  paypal.partner,
      user:     paypal.user
    )
  end

  def check
    if store.nil? || store.inactive?
      cancel
    else
      response = gateway.recurring_inquiry(recurring.profile_id)
      log response.inspect

      if response.params['status'] == 'ACTIVE'
        update if store.current_plan_price != recurring.value
      else
        recurring.update_attributes(canceled_at: DateTime.current)
      end
    end
  end

  def cancel
    response = gateway.cancel_recurring(recurring.profile_id)

    if response.success?
      recurring.update_attributes(canceled_at: DateTime.current)
    end

    log response.inspect

    response.success?
  end

  def update
    response = gateway.recurring(store.current_plan_price, nil, profile_id: recurring.profile_id, periodicity: :monthly)

    if response.success?
      recurring.update_attributes(value: store.current_plan_price)
    end

    log response.inspect
  end

  def log(text)
    recurring.logs.create(description: text)
  end
end
