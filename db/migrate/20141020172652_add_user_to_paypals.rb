class AddUserToPaypals < ActiveRecord::Migration
  def change
    add_column :paypals, :user, :string
  end
end
