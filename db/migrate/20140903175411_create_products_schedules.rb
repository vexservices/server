class CreateProductsSchedules < ActiveRecord::Migration
  def change
    create_table :products_schedules do |t|
      t.references :product, index: true
      t.references :schedule, index: true
    end
  end
end
