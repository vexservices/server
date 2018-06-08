class AddFormattedNameToStores < ActiveRecord::Migration
  def change
    add_column :stores, :formatted_name, :text
  end
end
