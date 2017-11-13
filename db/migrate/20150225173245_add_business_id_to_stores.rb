class AddBusinessIdToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :business, index: true
  end
end
