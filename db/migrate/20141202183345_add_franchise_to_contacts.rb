class AddFranchiseToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :franchise, index: true
  end
end
