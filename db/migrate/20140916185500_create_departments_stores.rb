class CreateDepartmentsStores < ActiveRecord::Migration
  def change
    create_table :departments_stores do |t|
      t.references :department, index: true
      t.references :store, index: true
    end
  end
end
