class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.references :plan, index: true
      
      t.string :name
      t.string :phone
      t.string :cell_phone
      t.string :contact
      t.string :official_email
      t.string :website
      t.string :time_zone
      t.string :token
      t.string :number
      
      t.integer :payment_option
      
      t.boolean :corporate, default: false, null: false
      
      t.date :trial_at

      t.timestamps
    end
  end
end
