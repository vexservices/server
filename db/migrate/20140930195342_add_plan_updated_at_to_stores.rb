class AddPlanUpdatedAtToStores < ActiveRecord::Migration
  def change
    add_column :stores, :plan_updated_at, :datetime
  end
end
