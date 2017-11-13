class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :store, index: true
      
      t.string :token
      t.string :push_token
      t.string :kind, default: 1

      t.timestamps
    end
  end
end
