class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.references :store, index: true
      t.string :name

      t.timestamps
    end
  end
end
