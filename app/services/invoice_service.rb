class InvoiceService

  attr_accessor :stores

  def initialize(stores = nil)
    @stores = stores || Store.where(manual_payment: true).includes(:plan)
  end

  def create
    stores.find_each do |store|
      if plan = store.plan
        Invoice.create(
          store_id: store.id,
          value: store.current_plan_price,
          value_real: store.current_plan_price_real,
          plan_name: plan.name
        )
      end
    end
  end
end
