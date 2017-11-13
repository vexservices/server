class AddSuccessToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :success, :boolean, default: false, null: false
  end
end
