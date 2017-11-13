class AddTermVersionToStores < ActiveRecord::Migration
  def change
    add_column :stores, :term_version, :integer, default: 0, null: false
  end
end
