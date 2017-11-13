class AddPublishesCountToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :publishes_count, :integer, default: 0, null: false
  end
end
