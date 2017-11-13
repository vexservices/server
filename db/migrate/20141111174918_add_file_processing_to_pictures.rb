class AddFileProcessingToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :file_processing, :boolean, null: false, default: false
    add_column :pictures, :file_tmp, :string
  end
end
