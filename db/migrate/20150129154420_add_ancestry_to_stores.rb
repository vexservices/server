class AddAncestryToStores < ActiveRecord::Migration
  def change
    add_column :stores, :ancestry, :string
    add_column :stores, :ancestry_depth, :integer, default: 0, null: false

    add_index :stores, :ancestry
  end
end
