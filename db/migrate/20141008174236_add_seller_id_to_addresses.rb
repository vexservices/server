class AddSellerIdToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :seller, index: true
  end
end
