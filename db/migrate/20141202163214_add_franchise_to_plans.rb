class AddFranchiseToPlans < ActiveRecord::Migration
  def change
    add_reference :plans, :franchise, index: true
  end
end
