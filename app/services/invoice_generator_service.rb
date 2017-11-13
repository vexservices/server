class InvoiceGeneratorService

  attr_accessor :recurrings

  def initialize(recurrings = nil)
    @recurrings = recurrings || Recurring.actives.includes(store: [:plan])
  end

  def create
    recurrings.find_each do |recurring|
      if store = recurring.store
        Invoice.create(
          store_id: recurring.store_id,
          value: recurring.value,
          value_real: recurring.value_real,
          paid_at: DateTime.current,
          plan_name: store.plan_name,
          closed: true
        )
      end
    end
  end
end
