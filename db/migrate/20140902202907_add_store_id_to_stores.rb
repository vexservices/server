class AddStoreIdToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :store, index: true
  end
end
