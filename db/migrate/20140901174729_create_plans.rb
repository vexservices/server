class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      
      t.integer :monthly_posts
      t.integer :stores_limit
      t.integer :users_count

      t.boolean :popular, default: false, null: false
      t.boolean :visible, default: false, null: false
      t.boolean :email_support, default: false, null: false
      t.boolean :chat_support, default: false, null: false
      
      t.decimal :price, precision: 8, scale: 2
      t.decimal :individual_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
