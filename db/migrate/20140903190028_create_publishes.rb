class CreatePublishes < ActiveRecord::Migration
  def change
    create_table :publishes do |t|
      t.references :store, index: true
      t.references :product, index: true
      t.references :user, index: true
      
      t.decimal :price, precision: 8, scale: 2
      t.datetime :removed_at
      t.datetime :published_until

      t.timestamps
    end
  end
end
