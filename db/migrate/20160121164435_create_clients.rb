class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :store, index: true

      t.string :name
      t.string :username
      t.string :password_hash
      t.boolean :blocked

      t.timestamps
    end
  end
end
