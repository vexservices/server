class AddImportIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :import_id, :integer
  end
end
