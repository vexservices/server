class ScheduleService
  attr_accessor :schedules

  def initialize(schedules)
    @schedules = schedules
  end

  def publish
    schedules.find_each do |schedule|
      store = schedule.store

      next if store.setup_payment?

      count = 0

      schedule.products.find_each do |product|
        next unless store.can_publish_product?

        product.publish(store)
        count += 1
      end

      schedule.last_run = DateTime.now
      schedule.publishes_count = count
      schedule.save(validate: false)
    end
  end
end
