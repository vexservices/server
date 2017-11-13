class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :store, index: true
      
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
