class AddMxRecordToFranchises < ActiveRecord::Migration
  def change
    add_column :franchises, :mx_record, :text
    add_reference :franchises, :admin, index: true
  end
end
