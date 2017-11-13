class AddFranchiseToPaypals < ActiveRecord::Migration
  def change
    add_reference :paypals, :franchise, index: true
  end
end
