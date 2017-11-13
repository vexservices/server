class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :store, index: true
      
      t.date :initial
      t.date :final
      t.datetime :run_at
      t.datetime :last_run
      t.integer :products_count

      t.timestamps
    end
  end
end
