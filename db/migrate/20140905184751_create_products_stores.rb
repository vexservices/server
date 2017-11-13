class CreateProductsStores < ActiveRecord::Migration
  def change
    create_table :products_stores do |t|
      t.references :product, index: true
      t.references :store, index: true
    end
  end
end
