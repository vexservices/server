class CreatePaypals < ActiveRecord::Migration
  def change
    create_table :paypals do |t|
      t.string :login
      t.string :password
      t.string :partner, default: 'PayPal'
      t.boolean :sandbox, default: false, null: false
      t.string :country

      t.timestamps
    end
  end
end