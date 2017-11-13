class AddShowAllToProducts < ActiveRecord::Migration
  def change
    add_column :products, :show_all, :boolean, default: true, null: false
  end
end
