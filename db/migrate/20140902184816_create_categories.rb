class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :category, index: true
      t.references :store, index: true

      t.string :name
      
      t.timestamps
    end
  end
end
