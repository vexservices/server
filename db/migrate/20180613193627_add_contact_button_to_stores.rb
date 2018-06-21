class AddContactButtonToStores < ActiveRecord::Migration
  def change
    add_column :stores, :contact_button, :boolean
    add_column :stores, :map_button, :boolean
    add_column :stores, :chat_button, :boolean
    add_column :stores, :waze_button, :boolean
    add_column :stores, :favorite_button, :boolean
    add_column :stores, :show_address, :boolean
    add_column :stores, :show_on_map, :boolean
    add_column :stores, :map_icon, :integer
  end
end
