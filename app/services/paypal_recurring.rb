class PaypalRecurring
  attr_reader :corporate, :store, :franchise, :gateway

  def initialize(store)
    @store     = store
    @corporate = store.corporate

    if @corporate.belongs_to_franchise?
      @franchise = corporate.franchise
    end

    setup
  end

  def paypal
    if franchise.present?
      @paypal ||= franchise.paypals.search_by_country(store.address_country).first
      @paypal ||= franchise.paypals.search_by_country('US').first
    end

    @paypal ||= Paypal.master.search_by_country(store.address_country).first
    @paypal ||= Paypal.master.search_by_country('US').first
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

  def create(credit_card)
    response = gateway.recurring(
      store.current_plan_price,
      credit_card,
      periodicity: :monthly,
      starting_at: Date.today.at_beginning_of_month.next_month
    )

    if response.success?
      recurring = store.recurrings.create(
        profile_id: response.profile_id,
        value: store.current_plan_price,
        credit_card_number: credit_card.display_number,
        value_real: store.current_plan_price_real
      )

      recurring.logs.create(description: response.inspect)
    else
      Rails.logger.info 'Paypal Recurring Error'
      Rails.logger.error response.inspect
    end

    response
  end
end
