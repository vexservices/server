class AddStoreIdToDepartments < ActiveRecord::Migration
  def change
    add_reference :departments, :store, index: true
  end
end
