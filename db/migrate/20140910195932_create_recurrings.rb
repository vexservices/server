class CreateRecurrings < ActiveRecord::Migration
  def change
    create_table :recurrings do |t|
      t.references :store, index: true
      
      t.string :profile_id
      t.decimal :value, precision: 8, scale: 2
      t.datetime :canceled_at
      t.string :credit_card_number

      t.timestamps
    end
  end
end
