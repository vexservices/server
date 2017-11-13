class AddFileProcessingToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_processing, :boolean, null: false, default: false
    add_column :images, :file_tmp, :string
  end
end
