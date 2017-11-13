class AddImportTypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :import_type, :integer, default: 0
  end
end
