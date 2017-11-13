class AddKeyToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :key, :string
  end
end
