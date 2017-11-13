class CreateClientsStores < ActiveRecord::Migration
  def change
    create_table :clients_stores do |t|
      t.references :client, index: true
      t.references :store, index: true
    end
  end
end
