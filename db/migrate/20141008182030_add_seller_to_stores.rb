class AddSellerToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :seller, index: true
  end
end
