class AddFranchiseToAdmins < ActiveRecord::Migration
  def change
    add_reference :admins, :franchise, index: true
  end
end
