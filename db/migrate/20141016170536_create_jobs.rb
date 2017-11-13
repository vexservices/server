class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :store, index: true
      t.text :log
      t.boolean :closed, default: false, null: false
      t.string :name
      t.string :file

      t.timestamps
    end
  end
end