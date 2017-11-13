class AddFranchiseToSellers < ActiveRecord::Migration
  def change
    add_reference :sellers, :franchise, index: true
  end
end
