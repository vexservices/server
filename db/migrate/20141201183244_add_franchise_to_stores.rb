class AddFranchiseToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :franchise, index: true
  end
end
