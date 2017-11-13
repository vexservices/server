class AddTrialPeriodToFranchises < ActiveRecord::Migration
  def change
    add_column :franchises, :trial_period, :integer, default: 30, null: false
  end
end
