class ScheduleObserver < ActiveRecord::Observer
  def before_save(schedule)
    schedule.products_count = schedule.products.count
  end
end